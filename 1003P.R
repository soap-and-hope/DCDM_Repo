getwd()
setwd("C:/Users/yaraa/Downloads/P1003/Group5/Group5/data/5")
install.packages("tidyverse")

library(tidyverse)
library(purrr)
install.packages("janitor")
library(janitor)

 
# Set the directory containing your files
file_directory <- "C:/Users/yaraa/Downloads/P1003/Group5/Group5/data/5"

# Get all file names in the directory
file_names <- list.files(file_directory, full.names = TRUE)

# Select the first 100 files for testing
test_file_names <- file_names[1:100]

# Function to read and clean individual files
clean_file <- function(file) {
  df <- read_delim(file, delim = ",", col_names = c("Column", "Value"), show_col_types = FALSE)
  
  # Pivot the data to use rows as columns
  df <- df %>%
    pivot_wider(names_from = Column, values_from = Value) %>%
    janitor::clean_names() %>%
    mutate(sample_id = basename(file))
  
  return(df)
}

# Read and clean the selected files into a list
cleaned_data_list <- map(test_file_names, clean_file)

# Combine all cleaned data frames into one
combined_data <- bind_rows(cleaned_data_list)

# Save the combined data frame to a new CSV file with a proper filename and extension
write_csv(combined_data, "C:/Users/yaraa/Downloads/P1003/test1_combined_data.csv")


