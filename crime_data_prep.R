# This script reads in all files as a single dataframe

# The following code checks to see if specified packages are installed, then 
# installs missing packages and loads them into the environment using 'require'.
# list required packages
pckges <- c("tidyverse", "janitor", "readr")
# determine packages not installed
mssng <- pckges[!(pckges %in% installed.packages()[,"Package"])]
# install missing
if(length(mssng)) install.packages(mssng, dependencies = TRUE, repos = "https://cloud.r-project.org/")
# load 
lapply(pckges, require, character.only = TRUE)


# Police Data
# ------------------

# read in multiple files from the data folder and append them into a single dataframe
wd <- getwd()
data <-
  list.files(path = paste0(wd, "/data"), pattern = "*.csv", full.names = TRUE) %>% 
  map_df(~read_csv(.))

glimpse(data)

# notice how column names have spaces, that's not good!
# Lets use clean_names() to tidy up the column names
data <- data %>% 
  janitor::clean_names() 

data$crime_type <- as.factor(data$crime_type)

glimpse(data)

# Save data to RDS so it can easily be loaded into a markdown doc.
saveRDS(data, file = 'crime_data')
