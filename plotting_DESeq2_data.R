# remove all rows with "NA" in the "pvalue" column
df <- df[complete.cases(df[ , 5]), ]
df$groupNA <- ifelse(is.na(df$padj), 1, 0))

# use ggplot to make boxplot of DESeq2 data
ggplot(as.data.frame(res[5]), aes(x=row.names(as.data.frame(res[5])), y=pvalue)) + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
