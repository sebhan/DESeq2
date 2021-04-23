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
mut <- "NPM1.y" # mutation to analyse
dataset <- DESeqDataSetFromMatrix(countData = ctsdata,
                              colData = coldata,
                              design = formula(paste("~", mut))) #formula(paste()) enables input of design as variable

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

# get vector of header names of dataframe "coldata"
names(coldata) # get specific value (e.g., fifth value) via names(coldata)[5]

# create data frames to append analysis values to
df1 <- data.frame(mut1=character(), mut2=character(),log2FoldChange=character(),pval=character(),padj=character(),
                  stringsAsFactors=FALSE)

# loop for iteration over gene list
genes = c("NPM1", "FLT3", "TP53") # toy gene list

for(i in genes)
{
    for(j in genes)
    {
        if(i != j) # i != j exludes comparison between the same gene (e.g., NPM1 and NPM1)
        {
            if(!(any(df1$mut1 == j & df1$mut2 == i))) # exclude previously examined pairs
              {
                dfTemp <- data.frame(mut1=i,mut2=j,log2FoldChange=0,pval=0.05,padj=1)
                df1 <- rbind(df1,dfTemp)
              }
        }
    }
}
