# Install missing libraries dynamically
required_packages <- c("tidyverse", "skimr", "dplyr")
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages, repos = "https://cloud.r-project.org")

library(tidyverse)
library(skimr)
library(dplyr)

print("Loading raw data.")

data <- read.csv("raw_data.csv", header = TRUE)
skim(data)

print("Cleaning data...")

data <- data %>%
  dplyr::distinct(id, .keep_all = TRUE) %>%
  dplyr::select(c(diagnosis, 
                  radius_mean, 
                  area_mean, 
                  radius_worst,
                  area_worst,
                  perimeter_worst,
                  perimeter_mean)) %>%
  dplyr::mutate(across(-c(diagnosis), as.numeric)) #%>%

print("Data cleaning done, saving file.")

write.csv(data, file = "cleaned_data.csv", row.names = FALSE)
