# read counts data (ctsdata), dropping gene name column
ctsdata <- read.csv(file = "ctsdata.csv", header=T, stringsAsFactors=FALSE)
ctsdata <- ctsdata[ , -1]

# read column data (coldata)
coldata <- read.csv(file = "coldata.csv", header=T, row.names=1)

dataset <- DESeqDataSetFromMatrix(countData = ctsdata,
                                  colData = coldata,
                                  design = ~ 1)
