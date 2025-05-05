# TitleL: Lasso regression on high-dimensional data
# Author: XShen
# Date: 2021-09-29



# Basic settings ----------------------------------------------------------

library(optparse)        # Parse arguments
library(dplyr)           # Data cleaning
library(glmnet)          # LASSO regression      
library(bigstatsr)       # For processing big matrices 
library(readr)           # For reading data
library(doParallel)      # For parallel computing

parse <- OptionParser()

option_list <- list(
   make_option('--methFolder', type='character', help="Folder for methylation", action='store'),
   make_option('--phenoFile', type='character', help='Output folder', action='store'),
   make_option('--phenoBinary', type='character', help='Is the phenotype binary? (yes/no)', action='store',default = 'no'),
   make_option('--outputFile', type='character', help='Filename for output', action='store',default='yes'),
   make_option('--subID', type='character', help='Linkage file', action='store',default=NULL),
   make_option('--cpgList', type='character', help='CpG to include', action='store',default=NULL))


args = commandArgs(trailingOnly=TRUE)
opt <- parse_args(OptionParser(option_list=option_list), args=args)

# Define variables ---------------------------------------------------------
D_METH = opt$methFolder
F_subID = opt$subID
F_cpg = opt$cpgList
F_pheno = opt$phenoFile
phenoBinary = opt$phenoBinary
phenoName = opt$phenoName
F_output = opt$outputFile

set.seed(1963) # for reproducibility

# Define process managing functions ---------------------------------------

log_file <- paste(F_output,'.log')
logging <- function(str) { 
   cat(paste0(paste0(str, collapse=''), '\n'), file=log_file, append=TRUE) 
   cat(paste0(paste0(str, collapse=''), '\n')) 
}



# Log arguments -----------------------------------------------------------

logging('Lasso regression')
logging(c("Started: ", date()))
logging(c('Methylation data folder: ', D_METH))
logging(c('Subject to include: ', F_subID))
logging(c('Phenotype file: ', F_pheno))
logging(c('Is the phenotype binary?: ', phenoBinary))
logging(c('Output file: ', F_output))
logging(' ')

# Load data ---------------------------------------------------------------

# M-values
ls.meth.f = list.files(path = D_METH,full.names = T)
meth <- as.list(ls.meth.f) %>%
   lapply(.,FUN=read_tsv) %>%
   lapply(.,FUN=function(x){
     colnames(x)[1]='ID' 
     return(x)}) %>% 
   purrr::reduce(left_join,by='ID')

# CpGs to include in the analysis
if(!is.null(opt[['cpgList']])) {
   logging(c('CpGs to include: ', F_cpg))
   cpg.ID=read_tsv(F_cpg,col_names = T)
   colnames(cpg.ID)='cpg'
   meth=meth[colnames(meth) %in% c('ID',cpg.ID$cpg), ]
}

# Use meth-pheno linkage file if provided
if(!is.null(opt[['subID']])) {
  # Load linkage file
  ID_linkage=read_tsv(F_subID) 
  colnames(ID_linkage)=c('ID_meth','ID_pheno')
  # Subset methylation data and include those in the linkage file
  meth = meth %>% right_join(.,ID_linkage,by=c('ID'='ID_meth'))
  # Replace methylation IDs with phenotype IDs
  meth = meth %>% select(-ID) %>% rename(ID=ID_pheno) %>% select(ID,everything())
}


logging('Methylation data loaded')
logging(c('NCpG = ',ncol(meth)-1))
logging(c('NSubject = ',nrow(meth)))


# load phenotypes
pheno.dat = read_tsv(F_pheno)

colnames(pheno.dat) = c('ID','Pheno')
rownames(pheno.dat) = pheno.dat$ID


# Prepare methylation and phenotype data ----------------------------------

# Find matching IDs
meth_pheno = meth %>% right_join(.,pheno.dat,by='ID') %>% 
  .[complete.cases(.),]

logging(c('N for DNAm-phenotype intersecting data: ',nrow(meth)))

# Transform methylation data into a matrix
meth_intersected <- meth_pheno %>%
  select(-Pheno) %>% 
  tibble::column_to_rownames(var="ID")

y.input = meth_pheno$Pheno

rm(meth) # Remove original large methylation matrix

logging('Phenotype loaded')


# Analysis ----------------------------------------------------------------

X.bm <- as.matrix(meth_intersected)

# cv lasso: fivefold cross-validation used for hyperparametre tuning
if (phenoBinary == 'yes') {
  x_model = 'binomial'
}else{
  x_model = 'gaussian'
}

# Find N of available cores for paralleling
k.core = parallelly::availableCores()
if (k.core > 1) {
  logging('Parallel computing enabled')
  logging(c('Number of cores: ',k.core))
} else {
  logging('Parallel computing disabled')
  k.core = 1
}
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
logging('Lasso finished')

# Save results -----------------------------------------------------------

save(cvfit,file=F_output %>% paste0(.,'.cvfit'))
write_tsv(weights,file=F_output)

logging(paste0('Lasso results saved in: ', F_output))
logging(paste0('Lasso model saved in: ', F_output, '.cvfit'))
logging(c("Finished: ", date()))
logging('\n')
gc()      

