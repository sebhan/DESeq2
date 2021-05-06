# take "res" DESeq2 data frame and convert to "regular" dataframe "df"
df <- as.data.frame(res)

# remove all rows with "NA" in the "pvalue" column
df <- df[complete.cases(df[ , 5]), ]

# iterate over df and create column "groupNA", where rows with p-adj = NA code as 0 and p-ajd =/= NA code 1
# input column "groupNA" as factor for use as plotting categories (NA and non-NA)
df$groupNA <- factor(ifelse(is.na(df$padj), 0, 1))

# order data frame, first on column "groupNA", second on col "pvalue"
df <- df[with(df, order(df$groupNA, df$pvalue)), ]

# use ggplot to make boxplot of DESeq2 data
ggplot(df, aes(x = interaction(row.names(df), groupNA), y = pvalue, fill = groupNA)) + geom_bar(position="dodge", stat = "identity") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
