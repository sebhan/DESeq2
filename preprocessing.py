import pandas as pd

# read counts data *.csv-file
ctsdata = pd.read_csv("C:/Users/sebastian.hansen/Documents/AML/DESeq2 analysis of mutation impact/merged_gene_counts.csv", sep="\t", index_col=False)
ctsdata = ctsdata.drop("Geneid", axis = 1)

# set underscore ("_") as separator (sep)
sep = "_"

# iterate over counts data file header and strip out extraneous data ("_exclrRNAsAligned...")
for row in ctsdata.head(1):
    strip = row.split(sep, 1)[0] # split the column name into two at the separator ("_")
    # print(row, "|", strip) # used to check that all names are correct
    ctsdata = ctsdata.rename({row: strip}, axis ="columns") # append all the "stripped" names to existing header      
    
# identify and remove duplicate genes in counts data
ctsdata = ctsdata.drop_duplicates(subset="gene")

# read column data
coldata = pd.read_csv("C:/Users/sebastian.hansen/Documents/AML/DESeq2 analysis of mutation impact/mutation_groups_AS_version2.csv", sep="\t", index_col=0)
coldata = coldata.transpose()

#check if all patient IDs in coldata also exist in ctsdata
coldata.columns.intersection(ctsdata.columns)

# transpose column data back to correct orientation
coldata = coldata.transpose()

# select which column(s) to keep in coldata
coldata_stripped = coldata[["NPM1.y"]].copy()

# sort the data frames, so that patient IDs are sorted for DESeq analysis in R
ctsdata = ctsdata.reindex(sorted(ctsdata.columns), axis=1)
coldata_stripped.sort_index(inplace=True)

# save the column data and counts data to *.csv-files
coldata_stripped.to_csv("C:/Users/sebastian.hansen/Documents/AML/DESeq2 analysis of mutation impact/coldata.csv", sep=",")
ctsdata.to_csv("C:/Users/sebastian.hansen/Documents/AML/DESeq2 analysis of mutation impact/ctsdata.csv", sep=",", index=False)
