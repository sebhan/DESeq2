# set working directory
setwd("C:/Users/sebastian.hansen/Documents/AML/DESeq2 analysis of mutation impact")

# load relevant libraries
library(DESeq2)

# read .csv files
ctsdata <- read.csv(file="ctsdata.csv", row.names=119)
coldata <- read.csv(file="coldata.csv", row.names=1)

# check if sorted ctsdata and coldata names are the same
identical(sort(rownames(coldata)), sort(colnames(ctsdata))) # output "[1] TRUE"

# make DESeq data set from imported data
dataset <- DESeqDataSetFromMatrix(countData = ctsdata,
                              colData = coldata,
                              design= ~ NPM1.y)

# run DESeq
dds <- DESeq(dataset)

# get results of DESeq analysis
results(dds)

# set results to variable called "res" (results)
res <- results(dds)

# create MA-plot (where M is log ratio, and A is mean average)
plotMA(res)

# get specific columns of res dataframe
res[,2] # log2FoldChange
res[,5] # pvalue
res[,6] # padj
