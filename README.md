
The question has been solved using both R and Python languages.
Python is used only for questions 2 and 3.(also used for the addiitonal analysis) 
R is used for the graphs in the assessment as the ggplot functionality in R provides better functionality, readability and ease with respect to plots.  

Question 3.py
 Objective - The file has two functions for both questions 2 and 3. The script contains two functions that find the most common mutations and subsets the .maf files to contain only non-silent mutations.
 Libraries used - Pathlib, Collections, Pandas.
 Input- path of the directory containing the 50 .maf  files.
 Output- list of tuples with 15 most commonly occuring genes and the number of occurences of these genes.
 		The combined .maf file contains only non-silent mutation entries from all 50 input files.
 		This file is used for the further analysis questions. It also serves as an answer for question 2 of the asssesment.  

Question_4_5.r

Objective - This script is to answer Question 4 and 5. The script finds the significantly enriched genes in the responders vs non-responders. The script also plots the results of the statistical analysis.
Libraries - dplyr, ggplot2, maftools 
Input - The combined .maf file (non-silent mutations only), sample .tsv file
Output- The scatter plot of -log10 FDR vs the number of responded mutated patients for each significantly enriched gene.


Question_4_5_alternate.r

Objective - This scripts is an attempt to improve readability of the graph produced by Question_4_5.r.
Libraries - dplyr, ggplot2, maftools 
Input - The combined .maf file (non-silent mutations only), sample .tsv file
Output- The scatter plot of the number of responder patients with the most significantly enriched gene vs the gene names. The scatter points are grouped based on p-value.

Question 6.r 

Objective - This script shows the number of non-synonymous mutations per mega base vs patient ID for the mutation vs wild type samples.
Libraries - Libraries - dplyr, ggplot2, maftools, stringr
Input - The combined .maf file (non-silent mutations only), sample .tsv file
Output- The scatter plot of the number non-synonymous mutation for the 25 responders, grouped based on the mutation vs wild type classification for each sample.
