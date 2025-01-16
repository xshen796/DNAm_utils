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

|            |     Subj1 |     Subj2 |     Subj3 |     Subj4 |     Subj5 |
| :--------- | --------: | --------: | --------: | --------: | --------: |
| cg49123360 | 0.5231381 | 0.8066509 | 0.9505535 | 0.1532291 | 0.1069058 |
| cg79085587 | 0.2243690 | 0.2702841 | 0.2621469 | 0.0549557 | 0.6056434 |
| cg61275540 | 0.3724953 | 0.8267662 | 0.2375944 | 0.1097258 | 0.0449981 |
| cg99403679 | 0.9043105 | 0.5321594 | 0.2436040 | 0.4547870 | 0.0738404 |
| cg11744587 | 0.5345340 | 0.6643729 | 0.4782786 | 0.0915789 | 0.5514271 |
| cg68071820 | 0.9439010 | 0.0681367 | 0.2898211 | 0.4249326 | 0.0135043 |
| cg52967377 | 0.0810545 | 0.5843078 | 0.5266053 | 0.4795021 | 0.7350085 |
| cg59948332 | 0.8918887 | 0.2244347 | 0.7388077 | 0.9362670 | 0.9720218 |
| cg22372745 | 0.1652391 | 0.1587088 | 0.0203852 | 0.3462416 | 0.0024446 |
| cg66994061 | 0.6089871 | 0.4118511 | 0.3910086 | 0.7016009 | 0.9672379 |

### Sumstats from training model

  - Input format: .tsv file; Flag: –lassoCoef

  - Description: A file with two columns, the first one for subject IDs
    and the other for weights. The first row should be the header.

  - Example

| ID                |     pheno |
| :---------------- | --------: |
| pheno\_SubjID\_10 | 0.8109763 |
| pheno\_SubjID\_71 | 0.1289868 |
| pheno\_SubjID\_25 | 0.7653875 |
| pheno\_SubjID\_95 | 0.7706441 |
| pheno\_SubjID\_65 | 0.6982086 |
| pheno\_SubjID\_37 | 0.8934515 |
| pheno\_SubjID\_21 | 0.0174457 |
| pheno\_SubjID\_88 | 0.5822599 |
| pheno\_SubjID\_42 | 0.2892251 |
| pheno\_SubjID\_80 | 0.3677834 |

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
