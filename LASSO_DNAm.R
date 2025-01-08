# TitleL: Lasso regression on high-dimensional data
# Author: XShen
# Date: 2021-09-29



# Basic settings ----------------------------------------------------------

library(optparse)        # Parse arguments
library(biglasso)        # Lasso regression
library(dplyr)           # Data cleaning
library(glmnet)          # LASSO regression      
library(bigstatsr)       # For processing big matrices 
library(readr)           # For reading data
library(doParallel)      # For parallel computing

parse <- OptionParser()

option_list <- list(
   make_option('--methFolder', type='character', help="Folder for methylation", action='store'),
   make_option('--subID', type='character', help='Linkage file', action='store'),
   make_option('--cpgList', type='character', help='Reference file for categorical variables', action='store'),
   make_option('--phenoFile', type='character', help='Output folder', action='store'),
   make_option('--phenoBinary', type='character', help='Is the phenotype binary? (yes/no)', action='store',default = 'no'),
   make_option('--phenoName', type='character', help='Colunm name of target phenotype', action='store',default='yes'),
   make_option('--outputFile', type='character', help='Filename for output', action='store',default='yes'))


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

log_file <- gsub('.txt','.log',F_output)
logging <- function(str) { 
   cat(paste0(paste0(str, collapse=''), '\n'), file=log_file, append=TRUE) 
   cat(paste0(paste0(str, collapse=''), '\n')) 
}



# Log arguments -----------------------------------------------------------

logging('Lasso regression')
logging(c("Started: ", date()))
logging(c('Methylation data folder: ', D_METH))
logging(c('Subject to include: ', F_subID))
logging(c('CpGs to include: ', F_cpg))
logging(c('Additional SNP CpGs to exclude: ', F_snp_ch_probe))
logging(c('Phenotype file: ', F_pheno))
logging(c('Phenotype: ', phenoName))
logging(c('Is the phenotype binary?: ', phenoBinary))
logging(c('Output file: ', F_output))
logging(' ')

# Load data ---------------------------------------------------------------

# M-values
ls.meth.f = list.files(path = D_METH,full.names = T)
meth <- as.list(ls.meth.f) %>%
   lapply(.,FUN=read_tsv) %>%
   bind_rows

# CpGs to include in the analysis
if(!is.null(opt[['cpgList']])) {
   cpg.ID=readRDS(F_cpg)
   meth=meth[rownames(meth) %in% cpg.ID$cpg, ]
}

# Use meth-pheno linkage file if provided
if(!is.null(opt[['subID']])) {
  # Load linkage file
  ID_linkage=read_tsv(F_subID,col_names = F) 
  colnames(ID_linkage)=c('ID_meth','ID_pheno')
  # Subset methylation data and include those in the linkage file
  meth = meth[rownames(meth) %in% ID_linkage$ID_meth,] %>% .[ID_linkage$ID_meth,]
  # Replace methylation IDs with phenotype IDs
  rownames(meth) = ID_linkage$ID_pheno
}


logging('Methylation data loaded')
logging(c('NCpG = ',nrow(meth)))
logging(c('NSubject = ',ncol(meth)))

# Transpose DNAm data. One participant per row.
meth = t(meth) 


# load phenotypes
pheno.dat=readRDS(F_pheno)
rownames(pheno.dat)=pheno.dat$ID


# Prepare methylation and phenotype data ----------------------------------
# Two objects need to have matched IDs

# Find matching IDs
meth = meth[rownames(meth) %in% pheno.dat$ID,]
a = intersect(row.names(meth), row.names(pheno.dat))

logging(c('N for DNAm-phenotype intersecting data: ',length(a)))

# Generate datasets with intersecting IDs for methylation and phenotype. IDs are in the same order.
meth_intersected <- meth[a,]
pheno_intersected <- pheno.dat[a,]
# Check order is correct
if (!all.equal(row.names(meth_intersected), row.names(pheno_intersected))){
   stop('Methylation and phenotype data need to have matching IDs',call.=F)
}

tmp.y=pheno_intersected[,phenoName]
y.input = tmp.y

rm(meth) # Remove original large methylation matrix

logging('Phenotype loaded')


# Analysis ----------------------------------------------------------------

X.bm <- as.matrix(big_meth)

# cv lasso: fivefold cross-validation used for hyperparametre tuning
if (phenoBinary == 'yes') {
  x_model = 'binomial'
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
cvfit <- cv.glmnet(x.bm, y.input, seed = 1234, nfolds = 5, family=x_model, parallel=TRUE, standardize=TRUE, type.measure='deviance') 

# get coefficients
weights = coef(cvfit,s='lambda.min') %>% .[-1,] %>%
  data.frame(Protein=names(.),coef=.) %>% 
  filter(coef!=0)
rownames(weights) = NULL

# stop parallel computing
stopImplicitCluster()
logging('Lasso finished')

# Save results -----------------------------------------------------------

save(cvfit,file=F_output %>% paste0(.,'.cvfit'))
write_tsv(weights,file=F_output)

logging('Lasso results saved in: ', F_output)
logging('Lasso model saved in: ', F_output %>% paste0(.,'.cvfit'))
logging(c("Finished: ", date()))
logging('\n')
gc()      

