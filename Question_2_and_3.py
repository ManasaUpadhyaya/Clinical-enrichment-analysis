'''
This python script contains the codes for Questions 3 of the assessment
First function - The script inputs the maf files as an input and finds the 15 most common mutations.
As mentioned in the question, the script considers only non -synonymous mutations.
The scripts outputs a list with the desired results

Second function - Additionally, the script also contains a piece of code that parses through all the maf files and
appends the non-silent mutation rows  into a single .maf file. This code is for the next few graph questions.
'''

from pathlib import Path
from collections import Counter
import pandas as pd

def combine_mafs(dir_maf, filename):
    dfs = []
    for file in dir_maf.glob('*.maf'):
        df1 = pd.read_table(file)
        df1.columns = [i.strip() for i in df1.columns]
        df1['source'] = file.name
        dfs.append(df1)
    df = pd.concat(dfs)
    df = df.loc[df['Variant_Classification'] != 'Silent']
    df1['Hugo_Symbol'] = df1['Hugo_Symbol'].str.strip()
    df.to_string(filename, index=False)

combine_mafs(Path("C:\\Users\\manas\\PycharmProjects\\Dana_Farber\\vanallen-assessment\\mafs"), "Combined_non-silent_mafs.maf")
dict_counts_genes = {}


def finding_top_15_genes(dir_maf):
    dfs = []
    for file in dir_maf.glob('*.maf'):
        df= pd.read_table(file)
        for row,column in df.iterrows():
            gene_name = column[0]
            if column[4] !=  'Silent':
                dfs.append(df)
                if gene_name in dict_counts_genes:
                    dict_counts_genes[gene_name]+= 1
                if gene_name not in dict_counts_genes:
                    dict_counts_genes[gene_name] = 1
    tmp = Counter(dict_counts_genes)
    top_15_genes = tmp.most_common(15)
    print(top_15_genes)
finding_top_15_genes(Path("C:\\Users\\manas\\PycharmProjects\\Dana_Farber\\vanallen-assessment\\mafs"))
