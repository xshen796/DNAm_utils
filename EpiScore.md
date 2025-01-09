Readme for EpiScore.R function
================
X Shen
09 January, 2025

## Summary

  - AD use data preparation: prep.AD\_phenotype.Rmd

  - Proteomic data and covariates preparation: prep.prot\_covs.Rmd

<!-- end list -->

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

    ## 
    ## Attaching package: 'lubridate'

    ## The following objects are masked from 'package:base':
    ## 
    ##     date, intersect, setdiff, union

## Mandatory Input Data

### Methylation data

  - Input format: folder; Flag: –methFolder

  - Description: DNAm data should be stored in .rds format. Columns are
    participants and rows are CpG
sites.

  - Example

|            |     Subj1 |     Subj2 |     Subj3 |     Subj4 |     Subj5 |
| :--------- | --------: | --------: | --------: | --------: | --------: |
| cg96773559 | 0.9064989 | 0.6944108 | 0.0498396 | 0.7458648 | 0.5400916 |
| cg34380622 | 0.9210043 | 0.7449388 | 0.3403705 | 0.3582078 | 0.3088762 |
| cg12381380 | 0.0022473 | 0.1850466 | 0.9915341 | 0.0843124 | 0.6757350 |
| cg95797372 | 0.2879289 | 0.3699498 | 0.7089619 | 0.1952614 | 0.8198242 |
| cg13636994 | 0.9884228 | 0.0349670 | 0.6324941 | 0.6599734 | 0.0932453 |
| cg12738449 | 0.2453668 | 0.8881122 | 0.5225083 | 0.5643300 | 0.8755685 |
| cg91168829 | 0.1250251 | 0.3921689 | 0.2020145 | 0.6961655 | 0.9035700 |
| cg28859687 | 0.3284957 | 0.9484051 | 0.6168840 | 0.9416085 | 0.3032013 |
| cg98617102 | 0.5606320 | 0.8716024 | 0.3521035 | 0.8484928 | 0.5393025 |
| cg92236279 | 0.6942836 | 0.6476436 | 0.1033756 | 0.3846023 | 0.6893379 |

### Sumstats from training model

  - Input format: .tsv file; Flag: –lassoCoef

  - Description: A file with two columns, the first one for subject IDs
    and the other for weights. The first row should be the header.

  - Example

| ID                |     pheno |
| :---------------- | --------: |
| pheno\_SubjID\_20 | 0.3975013 |
| pheno\_SubjID\_6  | 0.1585962 |
| pheno\_SubjID\_46 | 0.1981276 |
| pheno\_SubjID\_25 | 0.3803565 |
| pheno\_SubjID\_80 | 0.3313620 |
| pheno\_SubjID\_14 | 0.3538795 |
| pheno\_SubjID\_7  | 0.1246226 |
| pheno\_SubjID\_55 | 0.0793676 |
| pheno\_SubjID\_36 | 0.0608895 |
| pheno\_SubjID\_60 | 0.9552323 |

## Optional Inputs

### Subject IDs

  - Input format: .tsv file

  - Description: A file with one column of DNAm IDs for individuals to
    include in the analysis.

  - Example

| ID\_meth |
| :------- |
| Subj1    |
| Subj2    |
| Subj3    |
| Subj4    |
| Subj5    |

-----

## Example Script:

Call the function from terminal:

``` bash
Rscript EpiScore.R --methFolder data/GS_DNAm \
--lassoCoef result/LASSO_weights_MDD \
--out result/episcore_mdd
```
