Readme for EpiScore.R function
================
X Shen
16 January, 2025

## Summary

  - AD use data preparation: prep.AD\_phenotype.Rmd

  - Proteomic data and covariates preparation: prep.prot\_covs.Rmd

## Mandatory Input Data

### Methylation data

  - Input format: folder; Flag: –methFolder

  - Description: DNAm data should be stored in .rds format. Columns are
    participants and rows are CpG
sites.

  - Example

| ID     | cg57743234 | cg74296461 | cg61140945 | cg22744036 | cg69503314 | cg86419818 | cg19926433 | cg57033391 | cg67460685 | cg76071435 |
| :----- | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: |
| subj1  |  0.0524470 |  0.7965153 |  0.9609448 |  0.1946462 |  0.3028048 |  0.4647991 |  0.0416567 |  0.9507548 |  0.7836015 |  0.6898163 |
| subj2  |  0.1854706 |  0.4522461 |  0.0744238 |  0.2560973 |  0.9168755 |  0.6392861 |  0.2577848 |  0.5808428 |  0.4034098 |  0.5285657 |
| subj3  |  0.3465246 |  0.0341884 |  0.9116564 |  0.6486750 |  0.8576916 |  0.4134448 |  0.1333167 |  0.3545617 |  0.4676292 |  0.7617593 |
| subj4  |  0.7130662 |  0.8470392 |  0.7043547 |  0.6967427 |  0.1650109 |  0.1591981 |  0.9060050 |  0.8248282 |  0.1495894 |  0.2179579 |
| subj5  |  0.4607676 |  0.8467716 |  0.9325801 |  0.9268961 |  0.2857313 |  0.3302919 |  0.3438931 |  0.7217205 |  0.9365379 |  0.3472481 |
| subj6  |  0.9010468 |  0.4743412 |  0.9562354 |  0.8060693 |  0.2572576 |  0.8840951 |  0.7414880 |  0.2260997 |  0.5770028 |  0.3997886 |
| subj7  |  0.5230426 |  0.6424812 |  0.2246464 |  0.7289368 |  0.6895479 |  0.5472982 |  0.2046719 |  0.9597675 |  0.3863943 |  0.0268291 |
| subj8  |  0.1434923 |  0.5655726 |  0.6080765 |  0.5442836 |  0.5498060 |  0.7983244 |  0.3881336 |  0.4432478 |  0.6936056 |  0.1089127 |
| subj9  |  0.6710295 |  0.1183509 |  0.7721892 |  0.2721290 |  0.0685799 |  0.3339865 |  0.9296879 |  0.7960366 |  0.9148475 |  0.3688723 |
| subj10 |  0.7779708 |  0.0764793 |  0.3784345 |  0.9194996 |  0.5886748 |  0.1411834 |  0.1079470 |  0.5497199 |  0.5354084 |  0.5460337 |

### Sumstats from training model

  - Input format: .tsv file; Flag: –lassoCoef

  - Description: A file with two columns, the first one for subject IDs
    and the other for weights. The first row should be the header.

  - Example

| ID                |     pheno |
| :---------------- | --------: |
| pheno\_SubjID\_58 | 0.7218332 |
| pheno\_SubjID\_11 | 0.7853134 |
| pheno\_SubjID\_90 | 0.2209572 |
| pheno\_SubjID\_22 | 0.4565743 |
| pheno\_SubjID\_59 | 0.4643932 |
| pheno\_SubjID\_87 | 0.2949905 |
| pheno\_SubjID\_25 | 0.1686199 |
| pheno\_SubjID\_81 | 0.4622711 |
| pheno\_SubjID\_26 | 0.2544873 |
| pheno\_SubjID\_52 | 0.1290973 |

## Optional Inputs

### Subject IDs

  - Input format: .tsv file

  - Description: A file with one column of DNAm IDs for individuals to
    include in the analysis.

  - Example

| ID\_meth   |
| :--------- |
| ID         |
| cg57743234 |
| cg74296461 |
| cg61140945 |
| cg22744036 |
| cg69503314 |
| cg86419818 |
| cg19926433 |
| cg57033391 |
| cg67460685 |
| cg76071435 |

-----

## Example Script:

Call the function from terminal:

``` bash
Rscript EpiScore.R --methFolder data/GS_DNAm \
--lassoCoef result/LASSO_weights_MDD \
--out result/episcore_mdd
```
