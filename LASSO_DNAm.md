Readme for LASSO\_DNAm.R function
================
X Shen
05 May, 2025

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

  - Description: DNAm data should be stored in .tsv format. Columns are
    participants and rows are CpG
sites.

  - Example

| ID     | cg54709776 | cg28852643 | cg82822168 | cg55838641 | cg76971752 | cg87478078 | cg53597127 | cg82414550 | cg22927532 | cg93711783 |
| :----- | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: | ---------: |
| subj1  |  0.2482869 |  0.1693756 |  0.7831526 |  0.0864535 |  0.1718502 |  0.3857964 |  0.9152106 |  0.0582040 |  0.7122378 |  0.8708578 |
| subj2  |  0.3109062 |  0.0538198 |  0.9155095 |  0.9262595 |  0.2543646 |  0.2829651 |  0.2876860 |  0.1389582 |  0.2536123 |  0.4385759 |
| subj3  |  0.6819090 |  0.9368344 |  0.4923846 |  0.0411139 |  0.4372920 |  0.0208660 |  0.1573284 |  0.3723307 |  0.1524631 |  0.7464698 |
| subj4  |  0.0675364 |  0.4323795 |  0.0534522 |  0.0712538 |  0.1296514 |  0.0463922 |  0.8339990 |  0.4650169 |  0.1519323 |  0.2194656 |
| subj5  |  0.4254030 |  0.2467163 |  0.7728887 |  0.9949852 |  0.0482666 |  0.5965141 |  0.7694369 |  0.6052887 |  0.5636686 |  0.5707898 |
| subj6  |  0.0658242 |  0.9262703 |  0.0405884 |  0.3061353 |  0.9042184 |  0.8671214 |  0.0145059 |  0.1297851 |  0.3061270 |  0.9872464 |
| subj7  |  0.9321966 |  0.0790080 |  0.2244878 |  0.2691574 |  0.6297877 |  0.9310438 |  0.6045357 |  0.3586747 |  0.5852930 |  0.3816709 |
| subj8  |  0.4597800 |  0.8853938 |  0.2391810 |  0.9072450 |  0.8437561 |  0.6064826 |  0.3375272 |  0.5984434 |  0.2207606 |  0.7673589 |
| subj9  |  0.1236418 |  0.0184098 |  0.5928898 |  0.1659032 |  0.5669628 |  0.9966704 |  0.3228531 |  0.9893940 |  0.4610926 |  0.4363251 |
| subj10 |  0.7220897 |  0.9061156 |  0.6467075 |  0.0731315 |  0.1637132 |  0.3142062 |  0.5028191 |  0.9929464 |  0.5227294 |  0.0641425 |

### Phenotype data

  - Input format: .tsv file; Flag: –phenoFile

  - Description: A file with two columns, the first one for subject IDs
    and the other for phenotype values. The first row should be the
    header.

  - Example

| ID                |     pheno |
| :---------------- | --------: |
| pheno\_SubjID\_83 | 0.6694571 |
| pheno\_SubjID\_25 | 0.4794264 |
| pheno\_SubjID\_63 | 0.6778179 |
| pheno\_SubjID\_50 | 0.8215896 |
| pheno\_SubjID\_14 | 0.3226991 |
| pheno\_SubjID\_47 | 0.4990293 |
| pheno\_SubjID\_40 | 0.1262363 |
| pheno\_SubjID\_5  | 0.6004832 |
| pheno\_SubjID\_10 | 0.6608682 |
| pheno\_SubjID\_88 | 0.7593075 |

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
| subj1    | pheno\_SubjID\_13 |
| subj2    | pheno\_SubjID\_59 |
| subj3    | pheno\_SubjID\_11 |
| subj4    | pheno\_SubjID\_3  |
| subj5    | pheno\_SubjID\_54 |
| subj6    | pheno\_SubjID\_72 |
| subj7    | pheno\_SubjID\_60 |
| subj8    | pheno\_SubjID\_52 |
| subj9    | pheno\_SubjID\_47 |
| subj10   | pheno\_SubjID\_42 |

### CpGs to include

  - Input format: .tsv file

  - Description: A file with one column for CpG sites. The first row
    should be the header.

  - Example

| cpg        |
| :--------- |
| cg54709776 |
| cg28852643 |
| cg82822168 |
| cg55838641 |
| cg76971752 |
| cg87478078 |
| cg53597127 |
| cg82414550 |
| cg22927532 |
| cg93711783 |

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
--meth "TOYDATA_MRS/mval_test/*.tsv" \
--pheno TOYDATA_MRS/disorder.tsv \
--binary yes
```

### Run with conda

```bash
nextflow run LASSO_DNAm.nf \
-resume -qs 4 \
--meth "TOYDATA_MRS/mval_test/*.tsv" \
--pheno TOYDATA_MRS/disorder.tsv \
--binary yes \
-config LASSO_DNAm.config \
-profile conda 
```

### Run with docker

```bash
nextflow run LASSO_DNAm.nf \
-resume -qs 4 \
--meth "TOYDATA_MRS/mval_test/*.tsv" \
--pheno TOYDATA_MRS/disorder.tsv \
--binary yes \
-config LASSO_DNAm.config \
-profile docker
```

### Run with singularity

```bash
nextflow run LASSO_DNAm.nf \
-resume -qs 4 \
--meth "TOYDATA_MRS/mval_test/*.tsv" \
--pheno TOYDATA_MRS/disorder.tsv \
--binary yes \
-config LASSO_DNAm.config \
-profile singularity
```
