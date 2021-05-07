# input array data from RDS-file
mut <- readRDS("AML_mutation_DESeq.rds")

# drop fold change column
mut <- mut[,-1,]

# TO DO
# access array "mut" and drop all matrix rows where row pval = NA

# use melt() to reshape array to dataframe
df <- melt(mut)

# set new column names for dataframe "df"
df <- df[c(3,1,2,4)]
colnames(df) <- c("mut", "gene", "variable", "value")

# iterate over df and create column "padj_isNA", where rows with p-adj = NA code as 1 and p-ajd =/= NA code 0
# input column "padj_isNA" as factor for use as plotting categories (NA and non-NA)
# df$groupNA <- factor(ifelse(is.na(df$padj), 0, 1))
df$padj_isNA <- factor(ifelse(df$variable == "padj" & is.na(df$value), 1, 0))

# remove all rows with p-values equaling "NA"
df <- df[!(df$variable == "pval" & is.na(df$value)), ]

# removing p-value rows creates gaps in row numbering, so reset row numbering
rownames(df) <- NULL

# recast molten data (df <- melt(mut)) to "normal" df
df <- dcast(df, mut+gene+padj_isNA~variable)

# use ggplot to make boxplot of DESeq2 data
ggplot(df, aes(x = interaction(row.names(df), groupNA), y = pvalue, fill = groupNA)) + geom_bar(position="dodge", stat = "identity") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
