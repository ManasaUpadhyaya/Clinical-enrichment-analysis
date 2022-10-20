#Question 6:
# R script is the scatter plot that shows the number of non synonymous
#mutations per mega base in mutated(enriched) vs wild type(non-enriched) samples.
library(ggplot2)
library(readr)
library(dbplyr)
library(stringr)
maf_file <- data.table::fread("C:\\Users\\manas\\PycharmProjects\\Dana_Farber\\Combined_non-silent_mafs.maf")
patient_response_data <- "C:\\Users\\manas\\PycharmProjects\\Dana_Farber\\vanallen-assessment\\sample-information.tsv"

response_df <- read_tsv(patient_response_data)
only_response_patients<- subset(response_df, Response == "Responder")
enriched_for_ERCC2 <- subset(maf_file, Hugo_Symbol == "ERCC2")
plot_data<- merge(only_response_patients, enriched_for_ERCC2,by = "Tumor_Sample_Barcode", all = TRUE )

#Editing the data to : exclude dulplicate columns
plot_data<- subset(plot_data, select = -c(Protein_Change,t_alt_count, t_ref_count,source, Variant_Classification, Variant_Type, Reference_Allele, Tumor_Seq_Allele1, Tumor_Seq_Allele2, Matched_Norm_Sample_Barcode.x, Chromosome, Start_position, End_position, Matched_Norm_Sample_Barcode.y))
#Editing column titles 
colnames(plot_data)[7]<- "Enrichment_status_ERCC2" 
plot_data$Enrichment_status_ERCC2[plot_data$Enrichment_status_ERCC2 == "ERCC2"]<-"Mutated for ERCC2"
plot_data[is.na(plot_data)]<- "Wild type for ERCC2"

#Sorting the patient IDs for better viewability of the graph
plot_data$Patient_ID <- str_replace(plot_data$Patient_ID, "Patient-", " ")
plot_data$Patient_ID <- as.numeric(plot_data$Patient_ID)
sort(as.numeric(plot_data$Patient_ID))
plot_data<- plot_data[order(plot_data$Patient_ID, decreasing = FALSE), ]
plot_data$Patient_ID<- as.character(plot_data$Patient_ID)
plot_data
# Plotting the graph 
plot_data$Patient_ID <- factor(plot_data$Patient_ID, levels = plot_data$Patient_ID)
print(ggplot(plot_data, aes(x = Patient_ID , y = Nonsynonymous_mutations_per_Mb, colour = Enrichment_status_ERCC2)) +
  geom_point() + 
  guides(color=guide_legend("Enrichment information"))+
  labs(title = "Non-synonymous mutations per megabase in mutant vs wild-type responders", subtitle = "Plot of non-synonymous mutations in responded patients ",y= "Non-synonymous mutations per megabase ", x = "Patient ID")+
theme(axis.title = element_text(size = 6, face = "bold"), plot.title = element_text(size = 9, face ="bold"), plot.subtitle = element_text(size =5), 
      axis.text.x = element_text(size = 4, angle = 45), axis.text.y = element_text(size = 4, face = "bold"),
      legend.title = element_text(size=7, face = "bold"), legend.text = element_text(size=5),
      panel.border = element_rect(color = 'black', fill = NA, size = 0.5)))
  
                                                

