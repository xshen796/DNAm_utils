Readme for EpiScore.R function
================
X Shen
16 January, 2025

## Summary

  - AD use data preparation: prep.AD\_phenotype.Rmd

  - Proteomic data and covariates preparation: prep.prot\_covs.Rmd

## Mandatory Input Data

### Methylation data

  - Input format: folder; Flag: methFolder

  - Description: DNAm data should be stored in .tsv format. Columns are
    participants and rows are CpG
sites.

  - Example

| ID     | cg65562580 | cg58755605 | cg15547024 | cg90875238 | cg22520442 | cg89050253 | cg23917091 | cg29281736 | cg15156932 | cg49686931 |
| :----- | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: |
| subj1  |  0.1878908 |  0.7966967 |  0.6834445 |  0.1642763 |  0.3428239 |  0.8648741 |  0.8769863 |  0.0587758 |  0.7224561 |  0.7060325 |
| subj2  |  0.4610889 |  0.0449481 |  0.3078866 |  0.9516402 |  0.3020492 |  0.3762617 |  0.2652890 |  0.4775766 |  0.6500335 |  0.9251310 |
| subj3  |  0.6575679 |  0.3118979 |  0.3682094 |  0.2384946 |  0.6810177 |  0.2386706 |  0.5948195 |  0.2193627 |  0.5916478 |  0.9310458 |
| subj4  |  0.0644307 |  0.3133910 |  0.3660285 |  0.8903819 |  0.0264788 |  0.8898641 |  0.5998002 |  0.8181677 |  0.7699595 |  0.6714680 |
| subj5  |  0.9726665 |  0.2915087 |  0.7976528 |  0.4145207 |  0.5817652 |  0.0828731 |  0.5717566 |  0.6000646 |  0.6129355 |  0.3998278 |
| subj6  |  0.5365491 |  0.1865616 |  0.6285340 |  0.4791954 |  0.7385369 |  0.9602139 |  0.1391194 |  0.1397488 |  0.8148550 |  0.3768362 |
| subj7  |  0.9187966 |  0.8166953 |  0.1971392 |  0.6227610 |  0.2815650 |  0.8604821 |  0.4600545 |  0.6942598 |  0.7645674 |  0.6743710 |
| subj8  |  0.3286658 |  0.7353147 |  0.9989366 |  0.7641625 |  0.8052807 |  0.5654322 |  0.0442544 |  0.2112648 |  0.0726406 |  0.3787586 |
| subj9  |  0.5612869 |  0.7858385 |  0.7122667 |  0.7629297 |  0.6761254 |  0.5370794 |  0.1810389 |  0.1556546 |  0.3622993 |  0.8914412 |
| subj10 |  0.4894307 |  0.7316349 |  0.4793356 |  0.1484540 |  0.0929063 |  0.6164098 |  0.4199633 |  0.5034196 |  0.2868366 |  0.1227065 |

### Sumstats from training model

  - Input format: .tsv file; Flag: –lassoCoef

  - Description: A file with two columns, the first one for subject IDs
    and the other for weights. The first row should be the header.

  - Example

| ID                |     pheno |
| :---------------- | --------: |
| pheno\_SubjID\_89 | 0.1551166 |
| pheno\_SubjID\_60 | 0.2115214 |
| pheno\_SubjID\_21 | 0.3494226 |
| pheno\_SubjID\_85 | 0.2249050 |
| pheno\_SubjID\_31 | 0.8875878 |
| pheno\_SubjID\_9  | 0.2654665 |
| pheno\_SubjID\_74 | 0.9866025 |
| pheno\_SubjID\_73 | 0.7058483 |
| pheno\_SubjID\_64 | 0.1713574 |
| pheno\_SubjID\_83 | 0.0865731 |

## Optional Inputs

### Subject IDs

  - Input format: .tsv file

  - Description: A file with one column of DNAm IDs for individuals to
    include in the analysis.

  - Example

| ID\_meth   |
| :--------- |
| ID         |
| cg65562580 |
| cg58755605 |
| cg15547024 |
| cg90875238 |
| cg22520442 |
| cg89050253 |
| cg23917091 |
| cg29281736 |
| cg15156932 |
| cg49686931 |

-----

## Example Script:

Call the function from terminal:

``` bash
Rscript EpiScore.R --methFolder data/GS_DNAm \
--lassoCoef result/LASSO_weights_MDD \
--out result/episcore_mdd
```

``` bash
Rscript EpiScore.R --methFolder mval_test \
--lassoCoef LASSO_weights_MDD \
--out episcore_mdd
```
