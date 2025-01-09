Readme for LASSO\_DNAm.R function
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
| cg20567477 | 0.2204091 | 0.7845849 | 0.3826824 | 0.5417183 | 0.8382301 |
| cg53675880 | 0.9345796 | 0.5439179 | 0.7904524 | 0.2550566 | 0.4499638 |
| cg91895075 | 0.9944191 | 0.0530436 | 0.5063214 | 0.5856431 | 0.5694327 |
| cg94028552 | 0.5452058 | 0.9397140 | 0.9160861 | 0.8382101 | 0.4585132 |
| cg95063975 | 0.8527328 | 0.8749841 | 0.6608610 | 0.2993187 | 0.4812044 |
| cg13897507 | 0.6155975 | 0.8259160 | 0.9834906 | 0.1824802 | 0.9673496 |
| cg78620322 | 0.7316578 | 0.1883415 | 0.6547751 | 0.6960127 | 0.8839418 |
| cg79418413 | 0.0744379 | 0.4948531 | 0.1851486 | 0.7751455 | 0.9838138 |
| cg54896914 | 0.5720980 | 0.7100954 | 0.9796292 | 0.2758440 | 0.2461286 |
| cg51985307 | 0.4560310 | 0.5441863 | 0.6044658 | 0.6321864 | 0.3314662 |

### Sumstats from training model

  - Input format: .tsv file; Flag: –lassoCoef

  - Description: A file with two columns, the first one for subject IDs
    and the other for weights. The first row should be the header.

  - Example

| ID                |     pheno |
| :---------------- | --------: |
| pheno\_SubjID\_86 | 0.9539865 |
| pheno\_SubjID\_12 | 0.2001767 |
| pheno\_SubjID\_4  | 0.0450945 |
| pheno\_SubjID\_8  | 0.6911618 |
| pheno\_SubjID\_10 | 0.1588084 |
| pheno\_SubjID\_2  | 0.0466029 |
| pheno\_SubjID\_92 | 0.3364968 |
| pheno\_SubjID\_53 | 0.9109739 |
| pheno\_SubjID\_16 | 0.7898800 |
| pheno\_SubjID\_98 | 0.6609930 |

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
