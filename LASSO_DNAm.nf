/*
  Lasso regression on high-dimensional DNAm data
*/

// Methylation files
params.meth = "*.tsv"
// phenotype file
params.pheno = "pheno.tsv"
// binary phenottype yes/no
params.binary = "no"
// pheno to methylation ID linker
params.linker = null
// GpGs to include
params.cpgs = null
// multiprocessing
params.cores = 4

workflow {

  /* Install required packages */
  // get R version
  VERSION_CH = VERSION()
    .view(it -> "Running R ${it[1]} on ${it[0]}, compiled with ${it[2]} / ${it[3]}")
  LIBRARY_CH = PACKAGES(VERSION_CH)

  // /* Methylation data */
  METH_CH = Channel.fromPath(params.meth, checkIfExists: true)
  RDS_CH = RDS(METH_CH.combine(LIBRARY_CH))
    .collect()

  /* Phenotype data */
  PHENO_CH = Channel.fromPath(params.pheno, checkIfExists: true)
  BINARY_CH = Channel.of(params.binary)

  /* lasso */
  LASSO_CH = LASSO(RDS_CH, PHENO_CH, BINARY_CH, LIBRARY_CH)

}

/* Get information about R version */
process VERSION {

  output:
  tuple env(RPLATFORM), env(RVERSION), env(C), env(FORTRAN)

  script:
  """
  RPLATFORM=\$(Rscript -e 'cat(R.version[["platform"]])')
  RVERSION=\$(Rscript -e 'cat(R.version[["major"]], ".", R.version[["minor"]], sep = "")')
  C=\$(Rscript -e 'cat(R_compiled_by()[["C"]])')
  FORTRAN=\$(Rscript -e 'cat(R_compiled_by()[["Fortran"]])')
  """
}

/* Install required packages */
process PACKAGES {
  tag("${platform}-${version}")

  input:
  tuple val(platform), val(version), val(c), val(fortran)

  output:
  path("${platform}-${version}")

  script:
  """
  #!Rscript
  dir.create("${platform}-${version}")
  required_packages = c("dplyr", "readr", "stringr", "purrr", "glmnet", "doParallel")
  for(p in required_packages) {
    if(!require(p, character.only = TRUE)) {
      install.packages(p, lib = "${platform}-${version}", repos = "https://cloud.r-project.org", character.only = TRUE)
    }
  }
  for(p in required_packages) {
    library(p, lib = c("${platform}-${version}", .libPaths()), character.only = TRUE)
  }
  """
}

/* Read methylation data into R */
process RDS {
  tag("${tsv.baseName}")

  input:
  tuple path(tsv), path(library)

  output:
  path("${tsv.baseName}.rds")

  script:
  """
  #!Rscript
  library(dplyr, lib = c("${library}", .libPaths()))
  library(readr, lib = c("${library}", .libPaths()))

  meth <- read_tsv("${tsv}")
  saveRDS(meth, "${tsv.baseName}.rds")
  """
}

/* Fit lasso */
process LASSO {
  tag("${pheno.baseName}")

  cpu = params.cores
  memory = (params.cores * 16).GB

  input:
  path(rds)
  path(pheno)
  val(binary)
  path(library)

  output:
  path("${pheno.baseName}.weights.tsv")

  script:
  """
  #!Rscript
  required_packages = c("tibble", "dplyr", "readr", "stringr", "purrr", "glmnet", "doParallel")
  for(p in required_packages) {
    library(p, lib = c("${library}", .libPaths()), character.only = TRUE)
  }

  meth_files <- str_split("${rds}", pattern = " ")[[1]]

  meth <- meth_files %>%
  lapply(.,FUN=readRDS) %>%
   lapply(.,FUN=function(x){
     colnames(x)[1]='ID' 
     return(x)}) %>%
  reduce(left_join,by='ID')

   # load phenotypes
  pheno.dat = read_tsv("${pheno}")
  phenoBinary = "${binary}"

  colnames(pheno.dat) = c('ID','Pheno')
  rownames(pheno.dat) = pheno.dat[['ID']]

  # Find matching IDs
  meth_pheno = meth %>% right_join(.,pheno.dat,by='ID') %>% 
  .[complete.cases(.),]

  # Transform methylation data into a matrix
  meth_intersected <- meth_pheno %>%
    select(-Pheno) %>% 
    tibble::column_to_rownames(var="ID")

  y.input = meth_pheno[['Pheno']]

    
  # Analysis ----------------------------------------------------------------

  X.bm <- as.matrix(meth_intersected)

  # cv lasso: fivefold cross-validation used for hyperparametre tuning
  if (phenoBinary == 'yes') {
    x_model = 'binomial'
  } else {
    x_model = 'gaussian'
  }

  # Find N of available cores for paralleling
  k.core = ${task.cpu}
  registerDoParallel(k.core)

  # Lasso regression
  cvfit <- cv.glmnet(X.bm, y.input, seed = 1234, nfolds = 5, family=x_model, parallel=TRUE, standardize=TRUE, type.measure='deviance') 

  # get coefficients
  weights = coef(cvfit,s='lambda.min') %>% .[-1,] %>%
    data.frame(Marker=names(.),coef=.) %>% 
    filter(coef!=0)
  rownames(weights) = NULL

  # stop parallel computing
  stopImplicitCluster()

  # Save results -----------------------------------------------------------

  save(cvfit,file=paste0("${pheno.baseName}", ".cvfit"))
  write_tsv(weights,file=paste0("${pheno.baseName}", ".weights.tsv"))  
  """
}