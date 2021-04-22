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

# get vector of header names of dataframe "coldata"
names(coldata) # get specific value (e.g., fifth value) via names(coldata)[5]

# create data frames to append analysis values to
df1 <- data.frame(mutationPair=character(),log2FoldChange=character(),pval=character(),padj=character(),
                 stringsAsFactors=FALSE)
dfTemp <- data.frame(paste(genes[1],genes[2]),0,0.05,1)
names(dfTemp) <- c("mutationPair","log2FoldChange","pval","padj") # note: make sure that dfTemp header names match df1 headers

# append fake values
genes <- c("NPM1","FLT3","TP53") # toy gene list
dfTemp <- data.frame(paste(genes[1],genes[2]),0,0.05,1) # "paste()" makes string from gene list values
df1 <- rbind(df1,dfTemp)

# loop for iteration over gene list
for(i in genes)
{
    for(j in genes)
    {
        if(i != j) # i != j exludes comparison between the same gene (e.g., NPM1 and NPM1)
            {
            print(c(i,j))
            }
    }
}
