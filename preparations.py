import pandas as pd

#import the counts data (ctsdata) and drop the "Geneid"-column
ctsdata = pd.read_csv("C:/Users/sebastian.hansen/Documents/AML/DESeq2 analysis of mutation impact/merged_gene_counts_stripped.csv", sep="\t", index_col=1)
ctsdata = ctsdata.drop("Geneid", axis = 1)

#import the columns data (coldata) and transpose (so that ctsdata and coldata headers are the same)
coldata = pd.read_csv("C:/Users/sebastian.hansen/Documents/AML/DESeq2 analysis of mutation impact/mutation_groups_AS_version2.csv", sep="\t", index_col=0)
coldata = coldata.transpose()

#check if all patient IDs in coldata also exist in ctsdata
coldata.columns.intersection(ctsdata.columns)
