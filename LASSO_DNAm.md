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

| ID     | cg31602765 | cg71696187 | cg97019543 | cg53860778 | cg56733852 | cg70989893 | cg55108201 | cg60940600 | cg18973002 | cg17936622 |
| :----- | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: |
| subj1  |  0.5426508 |  0.8308050 |  0.8638713 |  0.7398929 |  0.0073558 |  0.9303585 |  0.5460656 |  0.8375024 |  0.7690491 |  0.4602612 |
| subj2  |  0.8711902 |  0.3836287 |  0.2282740 |  0.0786861 |  0.5134351 |  0.0758845 |  0.5038607 |  0.3202991 |  0.4782370 |  0.0080568 |
| subj3  |  0.9799140 |  0.7358747 |  0.9705937 |  0.1328087 |  0.1736585 |  0.7732009 |  0.0972177 |  0.1487135 |  0.1880891 |  0.0179580 |
| subj4  |  0.1267063 |  0.6941676 |  0.7782867 |  0.7046723 |  0.0995432 |  0.9401981 |  0.4495978 |  0.1550584 |  0.2868786 |  0.2995916 |
| subj5  |  0.6776002 |  0.1978433 |  0.6227569 |  0.7360512 |  0.3407551 |  0.5141476 |  0.0183764 |  0.0456632 |  0.6678010 |  0.1245773 |
| subj6  |  0.0166572 |  0.3164013 |  0.8413549 |  0.6894399 |  0.8933338 |  0.0651360 |  0.7104200 |  0.3621154 |  0.7454814 |  0.7248059 |
| subj7  |  0.1993932 |  0.5187576 |  0.5056179 |  0.7695172 |  0.4207007 |  0.7646030 |  0.1927723 |  0.5411525 |  0.6863808 |  0.3383740 |
| subj8  |  0.4768868 |  0.2149300 |  0.5982412 |  0.1772145 |  0.0473879 |  0.7801199 |  0.4691668 |  0.0118916 |  0.5009157 |  0.8220485 |
| subj9  |  0.8027522 |  0.5091437 |  0.7558950 |  0.5626690 |  0.5214343 |  0.9968115 |  0.7078440 |  0.2392420 |  0.1290033 |  0.9332041 |
| subj10 |  0.1189982 |  0.2283194 |  0.4340610 |  0.2811943 |  0.4188920 |  0.2916319 |  0.1707687 |  0.1370217 |  0.7626721 |  0.0343706 |

### Phenotype data

  - Input format: .tsv file; Flag: –phenoFile

  - Description: A file with two columns, the first one for subject IDs
    and the other for phenotype values. The first row should be the
    header.

  - Example

| ID                |     pheno |
| :---------------- | --------: |
| pheno\_SubjID\_56 | 0.4608183 |
| pheno\_SubjID\_27 | 0.2959442 |
| pheno\_SubjID\_25 | 0.4563402 |
| pheno\_SubjID\_13 | 0.5750666 |
| pheno\_SubjID\_48 | 0.6103059 |
| pheno\_SubjID\_71 | 0.2595902 |
| pheno\_SubjID\_24 | 0.7131882 |
| pheno\_SubjID\_14 | 0.7845280 |
| pheno\_SubjID\_23 | 0.3225498 |
| pheno\_SubjID\_86 | 0.1958193 |

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

| ID\_meth | ID\_pheno          |
| :------- | :----------------- |
| subj1    | pheno\_SubjID\_24  |
| subj2    | pheno\_SubjID\_76  |
| subj3    | pheno\_SubjID\_17  |
| subj4    | pheno\_SubjID\_55  |
| subj5    | pheno\_SubjID\_65  |
| subj6    | pheno\_SubjID\_50  |
| subj7    | pheno\_SubjID\_51  |
| subj8    | pheno\_SubjID\_100 |
| subj9    | pheno\_SubjID\_18  |
| subj10   | pheno\_SubjID\_93  |

### CpGs to include

  - Input format: .tsv file

  - Description: A file with one column for CpG sites. The first row
    should be the header.

  - Example

| cpg        |
| :--------- |
| cg31602765 |
| cg71696187 |
| cg97019543 |
| cg53860778 |
| cg56733852 |
| cg70989893 |
| cg55108201 |
| cg60940600 |
| cg18973002 |
| cg17936622 |

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

``` bash
cd TOYDATA_MRS
Rscript LASSO_DNAm.R --methFolder mval_test \
--phenoFile disorder.tsv \
--phenoBinary yes \
--phenoName MDD \
--subID ID_linkage.tsv \
--outputFile LASSO_weights_MDD
```

## Run as a workflow

```bash
nextflow run LASSO_DNAm.nf \
-resume -qs 4 \
--meth "mval_test/*.tsv" \
--pheno disorder.tsv \
--binary yes
```

### Run with conda

```bash
nextflow run LASSO_DNAm.nf \
-resume -qs 4 \
--meth "TOYDATA_MRS/mval_test/*.tsv" \
--pheno TOYDATA_MRS/disorder.tsv \
--binary yes \
-profile conda \
-config LASSO_DNAm.config \
-with-conda \
-with-report
```