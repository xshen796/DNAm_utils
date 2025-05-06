## Create DNAm scores in a testing dataset
## By X Shen
## 09/01/2025

## Info on file formats
## pheno_file is a file with a column called ID which matches the methylation ID (colnames) in prenormalized beta file
## coef is a 2 column file with cpg and coefficient (coef.name) and (coef.value)
## output location is the name of the output file

# Basic settings ----------------------------------------------------------

library(data.table)
library(dplyr)
library(optparse)
library(tibble)
library(readr)

# Parse arguments
args <- commandArgs(trailingOnly = FALSE)
parse <- OptionParser()
option_list <- list(
   make_option('--methFolder', type='character', help="Folder for methylation data (methylation data in tsv format)", action='store'),
   make_option('--subID', type='character', help="Subjects to include in the analysis", action='store',default=NULL),
   make_option('--lassoCoef', type='character', help='Lasso coefficients', action='store'),
   make_option('--out', type='character', help='Output file', action='store')
)
args = commandArgs(trailingOnly=TRUE)
opt <- parse_args(OptionParser(option_list=option_list), args=args)

D_METH = opt$methFolder
sub.ID = opt$subID
F_LassoCoef = opt$lassoCoef
output = opt$out


# Load data ---------------------------------------------------------------

## individuals to create scores in
pheno_file <- read_tsv(sub.ID) %>% .[,1] %>% as.vector

## LASSO co-efficients
coef.training <- read_tsv(F_LassoCoef)
colnames(coef.training)=c('Marker','Weight')

## Load methylation data files
ls.meth.file.loc <- list.files(path = D_METH,full.names=T)


# Define functions --------------------------------------------------------
# Process managing functions:
# Log process
log_file <- paste0(output,'.log')
logging <- function(str) { 
  cat(paste0(paste0(str, collapse=''), '\n'), file=log_file, append=TRUE) 
  cat(paste0(paste0(str, collapse=''), '\n')) 
}

# Calculate MRS by chromosome (main function)

calc_MRS <- function(F_mvalue,Obj_pheno,Obj_weight){
  
  logging(c('Processing:\t', F_mvalue %>% basename))
  
  # Load m-values
  data <- read_tsv(F_mvalue)
  
  # Subset individuals for testing
  if(!is.null(opt[['subID']])) {
    meth = data %>% filter(ID %in% subID)                          
  }else{
    meth=data
  }
  rm(data) # remove after use 
  
  # Select intersecting CpGs
  probes_ = intersect(colnames(meth),Obj_weight$Marker)
  # Reorder methylation data columns
  meth.cpg = meth %>% .[,c('ID',probes_)]
  # Reorder sumstats
  rownames(Obj_weight)=Obj_weight$Marker
  Obj_weight = Obj_weight[probes_,]
  
  # Calculate sum scores
  out_score=meth.cpg %>% select(-ID) %>% as.matrix %*% Obj_weight$Weight

  pred_dep.chr = data.frame(ID=meth.cpg$ID,Score=out_score)

  return(pred_dep.chr)
}


# Run analysis ------------------------------------------------------------

logging('Create MRS')
logging(c("Started: ", date()))
logging(c('M-value directory: ', D_METH))
logging(c('Testing sample: ', sub.ID))
logging(c('Lasso regression weights:', F_LassoCoef))
logging(c('Output file:', output))
logging(' ')


pred_dep.allCHR = as.list(ls.meth.file.loc) %>%
  lapply(.,FUN=calc_MRS,Obj_pheno=pheno_file,Obj_weight=coef.training) 

ref.ID=pred_dep.allCHR[[1]]$ID
pred_dep.allCHR = pred_dep.allCHR %>%
  purrr::reduce(full_join,by='ID')%>%
  select(-ID) %>%
  mutate(total.MRS=rowSums(.)) %>%
  mutate(ID=ref.ID) %>% 
  select(ID,total.MRS)

write_tsv(pred_dep.allCHR, file=output)

logging(c('Output saved:', output))
logging(c('Ended:  ', date()))
