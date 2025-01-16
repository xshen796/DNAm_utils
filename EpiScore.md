Readme for EpiScore.R function
================
X Shen
16 January, 2025

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
| cg34185044 | 0.1755606 | 0.1249566 | 0.1345140 | 0.4450672 | 0.6274651 |
| cg55243952 | 0.1610226 | 0.0198454 | 0.3571831 | 0.3932030 | 0.0446583 |
| cg55985639 | 0.3661557 | 0.2028537 | 0.1971302 | 0.7365554 | 0.6268051 |
| cg63067569 | 0.0652377 | 0.3334851 | 0.1360776 | 0.7775587 | 0.0798779 |
| cg86457579 | 0.2421473 | 0.1739392 | 0.0682751 | 0.2553396 | 0.4845460 |
| cg77933227 | 0.6134067 | 0.2724399 | 0.4360621 | 0.7422371 | 0.5097418 |
| cg65788095 | 0.2080043 | 0.3264512 | 0.4551746 | 0.4405167 | 0.9278664 |
| cg10495369 | 0.7660279 | 0.0268247 | 0.1520010 | 0.2567972 | 0.2514600 |
| cg20650720 | 0.0473088 | 0.0522518 | 0.8632179 | 0.6103390 | 0.3550115 |
| cg56814373 | 0.2286952 | 0.7595924 | 0.6920551 | 0.9694949 | 0.1043849 |

### Sumstats from training model

  - Input format: .tsv file; Flag: –lassoCoef

  - Description: A file with two columns, the first one for subject IDs
    and the other for weights. The first row should be the header.

  - Example

| ID                |     pheno |
| :---------------- | --------: |
| pheno\_SubjID\_41 | 0.5618825 |
| pheno\_SubjID\_23 | 0.7215345 |
| pheno\_SubjID\_89 | 0.9713722 |
| pheno\_SubjID\_52 | 0.5712680 |
| pheno\_SubjID\_92 | 0.5008952 |
| pheno\_SubjID\_74 | 0.0353182 |
| pheno\_SubjID\_32 | 0.1841389 |
| pheno\_SubjID\_98 | 0.8391033 |
| pheno\_SubjID\_80 | 0.5330138 |
| pheno\_SubjID\_19 | 0.5604475 |

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
