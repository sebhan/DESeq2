import pandas as pd

# set file input directory
filedir = "C:/Users/Admin/Documents/Lehtio_lab/AML/"

# read counts data *.csv-file
filename_ctsdata = "merged_gene_counts.csv"
ctsdata = pd.read_csv(filedir + filename_ctsdata, sep="\t", index_col=False)
ctsdata = ctsdata.drop("Geneid", axis = 1)

# iterate over counts data file header and strip out extraneous data ("_exclrRNAsAligned...")
sep = "_" # set underscore as separator
for row in ctsdata.head(1):
    strip = row.split(sep, 1)[0] # split the column name into two at underline
    # print(row, "|", strip) # used to check that all names are correct
    ctsdata = ctsdata.rename({row: strip}, axis ="columns") # append all the "stripped" names to existing header      
    
# identify and remove duplicate genes in counts data
ctsdata = ctsdata.drop_duplicates(subset="gene")

# read column data
filename_coldata = "mutation_groups_AS_version2.csv"
coldata = pd.read_csv(filedir + filename_coldata, sep="\t", index_col=0)
coldata = coldata.transpose()

#check if all patient IDs in coldata also exist in ctsdata
coldata.columns.intersection(ctsdata.columns)

# transpose column data back to correct orientation
coldata = coldata.transpose()

# sort the data frames, so that patient IDs are sorted for DESeq analysis in R
ctsdata = ctsdata.reindex(sorted(ctsdata.columns), axis=1)
coldata.sort_index(inplace=True)

# save the column data and counts data to *.csv-files
filedir = "C:/Users/Admin/Documents/Lehtio_lab/AML/DESeq2 analysis of mutation impact/"
filename_out_ctsdata = "ctsdata.csv"
ctsdata.to_csv(filedir + filename_out_ctsdata, sep=",", index=False)
filename_out_coldata = "coldata.csv"
coldata.to_csv(filedir + filename_out_coldata, sep=",")
