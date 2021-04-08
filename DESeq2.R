ctsdata <- read.csv(file = "ctsdata.csv", header=T)
coldata <- read.csv(file = "coldata.csv", header=F)

ddsFullCountTable <- DESeqDataSetFromMatrix(
    countData = ctsdata,
    colData = coldata,
    design = ~ TP53)
