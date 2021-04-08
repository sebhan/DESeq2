# set working directory
setwd("C:/Users/sebastian.hansen/Documents/AML/DESeq2 analysis of mutation impact")

# read .csv files
ctsdata <- read.csv(file = "merged_gene_counts_stripped.csv", sep = "\t")
coldata <- as.matrix(read.csv(file = "mutation_groups_AS_version2.csv", sep = "\t"))

# strip out extraneous lines to make dimensions between ctsdata and coldata the same (coldata [x1:y2] == ctsdata [y1:x2], where x1 == y1 and x2 == y2)
# for ctsdata, strip out first column ("Geneid")
ctsdata <- ctsdata[-c(1)]

# in ctsdata, strip out extraneous patient data ("exclrRNAsAligned... ") to harmonize with coldata
# TO DO, done via data preprocessing now (find-replace)

# get patient data column for ctsdata
ctsdata[0:0, ]

# get patient data column for coldata
coldata[, 1]
