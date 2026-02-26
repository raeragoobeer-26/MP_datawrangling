# installing necessary packages 
install.packages("tidyverse")
install.packages("palmerpenguins")
gitcreds::gitcreds_set() # had to generate new token to allow comm between R and Git

# calling necessary libraries with functions need to use 
library(tidyverse)
library(readxl)
excel_sheets("globalchange-project.xlsx")
library(dplyr)
library(ggplot2)
# reading in (messy) data
data <- read_xlsx("globalchange-project.xlsx")
data
data2 <- read_xlsx("globalchange-project.xlsx", range = "B1:M22") # combining summer and winter data for this project 
findata <- data2[-c(11, 12, 13), ] # removing NA rows 
colnames(findata) <- paste(colnames(findata), as.character(unlist(findata[1, ])), sep = "_") # adding units from rows to column headers 
findata <- findata[-1, ] # deleting row appended to headers 
findata <- findata[-1, ] # removing next row and will add necessary species names to notes 
summary(findata)
str(findata)

findata[] <- lapply(findata, function(x) { 
  if(is.character(x)) as.numeric(x) else x # ensuring data is numeric 
})
feeding_data <- findata[, 1:4]
# Convert to long format for ggplot
long_data <- pivot_longer(feeding_data, 
                          cols = c(`Grazer_(# particles g wwt)`,
                                   `Filter feeder_(# particles g wwt)`,
                                   `Deposit feeder_(# particles g wwt)`,
                                   `Carnivore_(# particles g wwt)`),
                          names_to = "Feeding_Type", values_to = "Particles_g_wwt")
colnames(feeding_data) <- c("Grazer", "Filter feeder", "Deposit feeder", "Carnivore", "sample_ID")
long_data$Feeding_Type <- factor(long_data$Feeding_Type,
                                 levels = c("Grazer_(# particles g wwt)",
                                            "Filter feeder_(# particles g wwt)",
                                            "Deposit feeder_(# particles g wwt)",
                                            "Carnivore_(# particles g wwt)"),
                                 labels = c("Grazer", "Filter feeder", "Deposit feeder", "Carnivore"))


ggplot(long_data, aes(x = Feeding_Type, y = Particles_g_wwt, fill = Feeding_Type)) +
  geom_boxplot() +
  labs(title = "Distribution of # Particles per g wwt by Feeding Type",
       x = "Feeding Type", y = "# Particles per g wet weight") +
  theme_minimal() +
  theme(legend.position = "none")





