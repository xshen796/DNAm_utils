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
| cg99808576 | 0.7580793 | 0.6711113 | 0.1862791 | 0.0387739 | 0.4703544 |
| cg43370914 | 0.7164923 | 0.8461825 | 0.4924027 | 0.5216293 | 0.6361390 |
| cg60114528 | 0.7406777 | 0.4251936 | 0.5867156 | 0.2784360 | 0.0042535 |
| cg15317832 | 0.8788700 | 0.7885871 | 0.4674406 | 0.3500915 | 0.4532773 |
| cg23168089 | 0.5970133 | 0.5285207 | 0.5812187 | 0.5601195 | 0.2951593 |
| cg21300982 | 0.0639307 | 0.1102370 | 0.2215183 | 0.1819389 | 0.7787049 |
| cg23584645 | 0.2469118 | 0.7380195 | 0.4181761 | 0.6019189 | 0.2784545 |
| cg92510734 | 0.2717692 | 0.9933256 | 0.7400938 | 0.3605912 | 0.3097712 |
| cg34169631 | 0.5077515 | 0.5641736 | 0.6666571 | 0.4203942 | 0.1880288 |
| cg32700299 | 0.3027429 | 0.9101564 | 0.3071581 | 0.3119508 | 0.8275176 |

### Phenotype data

  - Input format: .tsv file; Flag: –phenoFile

  - Description: A file with two columns, the first one for subject IDs
    and the other for phenotype values. The first row should be the
    header.

  - Example

| ID                |     pheno |
| :---------------- | --------: |
| pheno\_SubjID\_64 | 0.9284161 |
| pheno\_SubjID\_61 | 0.5967584 |
| pheno\_SubjID\_73 | 0.7806512 |
| pheno\_SubjID\_55 | 0.7101993 |
| pheno\_SubjID\_27 | 0.0861452 |
| pheno\_SubjID\_20 | 0.0919109 |
| pheno\_SubjID\_69 | 0.9891546 |
| pheno\_SubjID\_43 | 0.9623385 |
| pheno\_SubjID\_22 | 0.7035575 |
| pheno\_SubjID\_42 | 0.1003128 |

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

| ID\_meth   | ID\_pheno         |
| :--------- | :---------------- |
| cg99808576 | pheno\_SubjID\_35 |
| cg43370914 | pheno\_SubjID\_46 |
| cg60114528 | pheno\_SubjID\_38 |
| cg15317832 | pheno\_SubjID\_47 |
| cg23168089 | pheno\_SubjID\_64 |
| cg21300982 | pheno\_SubjID\_3  |
| cg23584645 | pheno\_SubjID\_62 |
| cg92510734 | pheno\_SubjID\_6  |
| cg34169631 | pheno\_SubjID\_8  |
| cg32700299 | pheno\_SubjID\_73 |

### CpGs to include

  - Input format: .tsv file

  - Description: A file with one column for CpG sites. The first row
    should be the header.

  - Example

| cpg        |
| :--------- |
| cg99808576 |
| cg43370914 |
| cg60114528 |
| cg15317832 |
| cg23168089 |

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
