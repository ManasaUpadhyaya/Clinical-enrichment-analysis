
#Question 5:
#This R script is the scatter plot that shows the number of mutated responded patients
#for the top significantly enriched genes in responders vs non-responders

library(maftools)
library(ggplot2)
library(dplyr)
maf_file <- data.table::fread("C:\\Users\\manas\\PycharmProjects\\Dana_Farber\\Combined_non-silent_mafs.maf")
patient_response_data <- "C:\\Users\\manas\\PycharmProjects\\Dana_Farber\\vanallen-assessment\\sample-information.tsv"
load_maf <- read.maf(maf = maf_file, clinicalData = patient_response_data)
enriched_data <- clinicalEnrichment(maf = load_maf, clinicalFeature = 'Response')
enriched_data
significant_data<- enriched_data$groupwise_comparision[p_value<= 0.05]
response_sig_data <- significant_data[significant_data$Group1 == "Responder"]

#plotting the graph 
responded_patients <- response_sig_data %>%
  mutate(number_responded = substr(n_mutated_group1, 1, 1)) %>%
  mutate(number_responded = as.numeric(number_responded)) %>%
  pull(number_responded)
print(ggplot(response_sig_data, aes(x= responded_patients, y = -log10(fdr), colour = Hugo_Symbol))+
  guides(color = guide_legend(title = "Significantly enriched genes ")) + 
  geom_point(position=position_jitter(height = 0.05), alpha = 0.5, size = 2) +
  xlim(0,25) +
  labs(title = "Significantly enriched genes in patients who responded to treatment", subtitle = "Plot of  log FDR vs number of patients",y= "-log10(FDR)", x = "Number of patients(responders) with enriched genes")+
  theme(axis.title = element_text(size = 6, face = "bold"), plot.title = element_text(size = 9, face ="bold"), plot.subtitle = element_text(size =5), 
        axis.text.x = element_text(size = 4), axis.text.y = element_text(size = 4),
        legend.title = element_text(size=7, face = "bold"), legend.text = element_text(size=5),
        panel.border = element_rect(color = 'black', fill = NA, size = 0.5)))



           
