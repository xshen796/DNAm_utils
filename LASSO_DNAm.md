Readme for LASSO\_DNAm.R function
================
X Shen
09 January, 2025

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
| cg41687433 | 0.0328036 | 0.5069854 | 0.5154289 | 0.4298443 | 0.6504929 |
| cg60356923 | 0.6168116 | 0.7781226 | 0.5226778 | 0.9718610 | 0.5086213 |
| cg74523371 | 0.8502125 | 0.3511032 | 0.8362307 | 0.9403505 | 0.7949673 |
| cg83346675 | 0.0221343 | 0.3757546 | 0.5420242 | 0.2710527 | 0.1683327 |
| cg49889895 | 0.1801220 | 0.3032879 | 0.3610749 | 0.9828737 | 0.1465335 |
| cg52583941 | 0.2533885 | 0.2980552 | 0.6048917 | 0.5750133 | 0.2298940 |
| cg72186359 | 0.6984935 | 0.1760727 | 0.5688981 | 0.2363225 | 0.6899863 |
| cg82076624 | 0.6683479 | 0.4817945 | 0.4240095 | 0.8131963 | 0.7617357 |
| cg73228211 | 0.8665034 | 0.8147452 | 0.5920859 | 0.0675362 | 0.6544997 |
| cg28526974 | 0.8290420 | 0.2858346 | 0.1205313 | 0.4202526 | 0.3995721 |

### Phenotype data

  - Input format: .tsv file; Flag: –phenoFile

  - Description: A file with two columns, the first one for subject IDs
    and the other for phenotype values. The first row should be the
    header.

  - Example

| ID                 |     pheno |
| :----------------- | --------: |
| pheno\_SubjID\_42  | 0.0655467 |
| pheno\_SubjID\_56  | 0.6063279 |
| pheno\_SubjID\_51  | 0.5642694 |
| pheno\_SubjID\_91  | 0.3592039 |
| pheno\_SubjID\_27  | 0.3629282 |
| pheno\_SubjID\_21  | 0.5783718 |
| pheno\_SubjID\_31  | 0.0201445 |
| pheno\_SubjID\_85  | 0.7697357 |
| pheno\_SubjID\_100 | 0.7399977 |
| pheno\_SubjID\_80  | 0.8357555 |

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
| Subj1    | pheno\_SubjID\_58 |
| Subj2    | pheno\_SubjID\_83 |
| Subj3    | pheno\_SubjID\_51 |
| Subj4    | pheno\_SubjID\_26 |
| Subj5    | pheno\_SubjID\_73 |

### CpGs to include

  - Input format: .tsv file

  - Description: A file with one column for CpG sites. The first row
    should be the header.

  - Example

| cpg        |
| :--------- |
| cg41687433 |
| cg60356923 |
| cg74523371 |
| cg83346675 |
| cg49889895 |

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
