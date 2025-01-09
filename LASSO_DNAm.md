Readme for LASSO\_DNAm.R function
================
X Shen
09 January, 2025

## Summary

  - AD use data preparation: prep.AD\_phenotype.Rmd

  - Proteomic data and covariates preparation: prep.prot\_covs.Rmd

<!-- end list -->

``` r
library(readr)           # Data loading/writing
library(dplyr)           # Data management
library(tidyr)           # Data management
library(stringr)         # Text processing
library(lubridate)       # Text processing
library(pbapply)         # Process control
library(knitr)           # Report generation
```

## Mandatory Input Data

### Methylation data

  - Input format: folder; Flag: –methFolder

  - Description: DNAm data should be stored in .rds format. Columns are
    participants and rows are CpG
sites.

  - Example

|            |     Subj1 |     Subj2 |     Subj3 |     Subj4 |     Subj5 |
| :--------- | --------: | --------: | --------: | --------: | --------: |
| cg18110006 | 0.2369988 | 0.9154421 | 0.5745167 | 0.2061446 | 0.2759184 |
| cg80927877 | 0.6485877 | 0.0088353 | 0.5169396 | 0.1267249 | 0.5533279 |
| cg23637442 | 0.0429876 | 0.3438764 | 0.7943838 | 0.8976791 | 0.4392131 |
| cg10759316 | 0.0280342 | 0.6461950 | 0.1117291 | 0.9149706 | 0.7034999 |
| cg63807450 | 0.5892352 | 0.8459624 | 0.8666333 | 0.6225479 | 0.5152651 |
| cg94496597 | 0.2310578 | 0.1164718 | 0.4799081 | 0.6756960 | 0.9568640 |
| cg25424806 | 0.3128536 | 0.6754776 | 0.2837118 | 0.4213428 | 0.2028101 |
| cg18452194 | 0.6866646 | 0.2993713 | 0.5326452 | 0.2632212 | 0.6994491 |
| cg38469277 | 0.4194282 | 0.3854823 | 0.2444283 | 0.0716163 | 0.4886464 |
| cg58822500 | 0.7078101 | 0.2961498 | 0.8975443 | 0.7819751 | 0.1733892 |

### Phenotype data

  - Input format: .tsv file; Flag: –phenoFile

  - Description: A file with two columns, the first one for subject IDs
    and the other for phenotype values. The first row should be the
    header.

  - Example

| ID                |     pheno |
| :---------------- | --------: |
| pheno\_SubjID\_11 | 0.2105734 |
| pheno\_SubjID\_9  | 0.6916629 |
| pheno\_SubjID\_69 | 0.7621899 |
| pheno\_SubjID\_21 | 0.3321896 |
| pheno\_SubjID\_71 | 0.5231056 |
| pheno\_SubjID\_5  | 0.5980030 |
| pheno\_SubjID\_89 | 0.6720635 |
| pheno\_SubjID\_25 | 0.6007466 |
| pheno\_SubjID\_8  | 0.3761421 |
| pheno\_SubjID\_52 | 0.5190449 |

### Other inputs

  - Is the phenotype binary or continuous?
    
      - Flag: –phenoBinary
    
      - Options: yes/no (Default = ‘no’)

  - Output file
    
      - Flag: –outputFile

## Optional Inputs

### Subject IDs

  - Input format: .tsv file

  - Description: A file with two columns, the first one for DNAm IDs and
    the other for phenotype IDs. The first row should be the header.

  - Example

| ID\_meth | ID\_pheno         |
| :------- | :---------------- |
| Subj1    | pheno\_SubjID\_89 |
| Subj2    | pheno\_SubjID\_36 |
| Subj3    | pheno\_SubjID\_54 |
| Subj4    | pheno\_SubjID\_68 |
| Subj5    | pheno\_SubjID\_25 |

### CpGs to include

  - Input format: .tsv file

  - Description: A file with one column for CpG sites. The first row
    should be the header.

  - Example

| cpg        |
| :--------- |
| cg18110006 |
| cg80927877 |
| cg23637442 |
| cg10759316 |
| cg63807450 |

### Other optional input

  - Name of phenotype
    
      - Flag: –phenoName

-----

## Example Script:

Call the function from terminal:

``` bash
Rscript LASSO_DNAm.R --methFolder data/GS_DNAm \
--phenoFile data/MDD.tsv \
--phenoBinary yes \
--phenoName MDD \
--subID data/DNAm_pheno_linkage.tsv \
--outputFile result/LASSO_weights_MDD
```
