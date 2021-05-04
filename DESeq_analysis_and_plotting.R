# set working directory
setwd("~/Lehtio_lab/AML/DESeq2 analysis of mutation impact")

# load relevant libraries
library(DESeq2)

# read .csv files
ctsdata <- read.csv(file="ctsdata.csv", row.names=119)
coldata <- read.csv(file="coldata.csv", row.names=1)

# check if sorted ctsdata and coldata names are the same
identical(sort(rownames(coldata)), sort(colnames(ctsdata))) # output "[1] TRUE"

# make list of mutations, which can be used to iterate over all mutations in loop
mutationsList <- list() # make empty list
for(i in colnames(coldata))
{
  mutationsList <- c(mutationsList, i)
}

# make mutation matrix list
mutationsMatrices <- list() # make empty list

# make short list for testing of loop by slicing mutations list
mutationsTest <- mutationsList[1:2]

for(currentMutation in mutationsTest){
  # make DESeq data set from imported data  
  dataset <- DESeqDataSetFromMatrix(countData = ctsdata,
                                      colData = coldata,
                                      design = formula(paste("~", currentMutation))) #formula(paste()) enables input of design as variable
    dds <- DESeq(dataset)
    res <- results(dds) # set results to variable called "res" (results)
    l2fc <- res[,2] # log2FoldChange
    pval <- res[,5] # pvalue
    padj <- res[,6] # padj
    m <- cbind(c(l2fc = l2fc, pval = pval, padj = padj)) # make matrix "m" from extracted arrays
    rownames(m) <- c(row.names(res)) # set m rownames from res dataframe rownames
    mutationsMatrices[[currentMutation]] <- m # add matrix m to mutationsMatrices
}
