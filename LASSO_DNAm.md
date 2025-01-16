Readme for LASSO\_DNAm.R function
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

| ID     | cg68519524 | cg38736278 | cg82991608 | cg69129949 | cg86392936 | cg79470226 | cg74249091 | cg27095384 | cg26029238 | cg35497320 |
| :----- | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: |
| subj1  |  0.7492679 |  0.8397241 |  0.3370379 |  0.3159877 |  0.3235996 |  0.4673095 |  0.4537439 |  0.0332434 |  0.5440723 |  0.5498298 |
| subj2  |  0.1366319 |  0.0584865 |  0.4915625 |  0.8046868 |  0.7879993 |  0.6690922 |  0.7409233 |  0.7894384 |  0.7422283 |  0.6463494 |
| subj3  |  0.2567898 |  0.0150068 |  0.6119189 |  0.8606340 |  0.5580574 |  0.5191827 |  0.3199154 |  0.2314316 |  0.7493433 |  0.4242567 |
| subj4  |  0.9750210 |  0.6546793 |  0.3901990 |  0.4228436 |  0.5479407 |  0.2932181 |  0.7623365 |  0.5278715 |  0.0574863 |  0.4656160 |
| subj5  |  0.5273059 |  0.2428110 |  0.6612921 |  0.3379346 |  0.2261102 |  0.5332699 |  0.4123469 |  0.1711178 |  0.8769576 |  0.8304051 |
| subj6  |  0.8392851 |  0.3457466 |  0.1327352 |  0.8210247 |  0.4653254 |  0.7517944 |  0.7016221 |  0.3055405 |  0.0319613 |  0.9497887 |
| subj7  |  0.9853331 |  0.9546018 |  0.4879885 |  0.0275862 |  0.9587189 |  0.7438322 |  0.6629048 |  0.2188763 |  0.8186708 |  0.6809223 |
| subj8  |  0.1341662 |  0.7750845 |  0.3616230 |  0.3287792 |  0.0168993 |  0.5339885 |  0.4854628 |  0.1481167 |  0.7973809 |  0.0699809 |
| subj9  |  0.2075884 |  0.9592858 |  0.1847708 |  0.5692799 |  0.0310896 |  0.3956107 |  0.2556840 |  0.0211456 |  0.6457408 |  0.2274989 |
| subj10 |  0.1586021 |  0.4324579 |  0.7299764 |  0.9048259 |  0.9244801 |  0.4503738 |  0.5793629 |  0.8532647 |  0.9477772 |  0.4353891 |

### Phenotype data

  - Input format: .tsv file; Flag: –phenoFile

  - Description: A file with two columns, the first one for subject IDs
    and the other for phenotype values. The first row should be the
    header.

  - Example

| ID                |     pheno |
| :---------------- | --------: |
| pheno\_SubjID\_90 | 0.5565418 |
| pheno\_SubjID\_40 | 0.0837550 |
| pheno\_SubjID\_69 | 0.7971758 |
| pheno\_SubjID\_78 | 0.0721071 |
| pheno\_SubjID\_2  | 0.0346039 |
| pheno\_SubjID\_4  | 0.8538939 |
| pheno\_SubjID\_64 | 0.6164255 |
| pheno\_SubjID\_43 | 0.4106984 |
| pheno\_SubjID\_93 | 0.5679877 |
| pheno\_SubjID\_21 | 0.9971011 |

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
| subj1    | pheno\_SubjID\_26 |
| subj2    | pheno\_SubjID\_60 |
| subj3    | pheno\_SubjID\_13 |
| subj4    | pheno\_SubjID\_76 |
| subj5    | pheno\_SubjID\_71 |
| subj6    | pheno\_SubjID\_31 |
| subj7    | pheno\_SubjID\_37 |
| subj8    | pheno\_SubjID\_14 |
| subj9    | pheno\_SubjID\_92 |
| subj10   | pheno\_SubjID\_5  |

### CpGs to include

  - Input format: .tsv file

  - Description: A file with one column for CpG sites. The first row
    should be the header.

  - Example

| cpg |
| :-- |
| 1   |
| 2   |
| 3   |
| 4   |
| 5   |

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
