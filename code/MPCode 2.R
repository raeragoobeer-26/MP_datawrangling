# installing necessary packages 
install.packages("tidyverse")
install.packages("palmerpenguins")
gitcreds::gitcreds_set() # had to generate new token to allow comm between R and Git

# calling necessary libraries with functions need to use 
library(tidyverse)
library(readxl)
excel_sheets("globalchange-project.xlsx")
# reading in (messy) data
data <- read_xlsx("globalchange-project.xlsx")
data
data2 <- read_xlsx("globalchange-project.xlsx", range = "B1:M22")
findata <- data2[-c(11, 12, 13), ]
summary (findata)




