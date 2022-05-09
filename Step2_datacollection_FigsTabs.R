# This script was used to gather kinetics points provided in Tables & Figures selected from
# relevant studies for studying the inactivation of coronaviruses 

#### Packages ####
library(metaDigitise)
library(readxl)
library(dplyr)
library(doBy)

# Set the working directory at the current location of this R script
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#### Import raw data and metata  ####
# Raw data and metadata were reported from different publications in the following Excel spreadsheeet
RawData_FileName <- "DataRecords_RawData.xlsx"





#### Figures digitalization ####
# For Figures, the images are provided in the 'source_figures' directory.
dd <- metaDigitise(dir = "source_figures/",
                          summary = FALSE)
# Two options are proposed: the users can choose to
# 1. digitalize new figures available in the above directory. The corresponding digitalized files will be created and saved afterwards in the sub-directory 'caldat'.
# 2. import the existing data to avoid re-doing this step for digitalized figures ('caldat' files already available)
# The digitalized data are stored as a R list in the R global environment, denoted 'dd'
# While performing new digitalization, users will have to digitize manually the figures (user's choice fo selecting calibrations points and points from the kinetics)


##### Calibrate the digitalized non proportional axes /!\ #####
# (e.g.: consecutive time points in plots at 1h,4h, 24h, etc.)
# The following R (sub)script enables to re-assign correct x values in the data set (study-dependent, check for more details).
# This script enables to directly modify values in the 'dd'
source("Step2.1_recalibrate_axes.R")

##### Prepare the data frame 'df' containing all digitalized kinetics #####
# This step aimed to extract, for each kinetic, the kinetic key, the different time points and viral measurements from digitalised files
# Initialize an empty data frame df
df <- data.frame(Kinetic_key = character(),
                 time_hours = numeric(),
                 y_variable = character(),
                 y = numeric())
for (i in 1:length(dd$scatterplot)) { # for each digitalized figure
  # extract, figure per figure, and combine data in the data frame df
  df <- rbind(df, data.frame(Kinetic_key = dd$scatterplot[[i]]$id, # 'id' (Kinetics_key),
                             time_hours = dd$scatterplot[[i]]$x, # x variable (time in hours),
                             y_variable = dd$scatterplot[[i]]$y_variable, # name of the y variable
                             y = dd$scatterplot[[i]]$y)) # digitalized values of y,
}
rm(i)





#### Extracting raw data from tables #####
# The raw data in tables from publications are retranscripted in different sheets of the Excel spreadsheet.
# The following R scripts extracted these data and combine in a data frame, denoted 'dt' (check for more details)
source("Step2.2_tables_extraction.R")




#### Combine all data from digitalized figures and tables ####
# Combine df and dt onto an unique data frame dk
dk <- rbind(df, dt)

# Sort the data frame dk by the kinetic keys and assign them as a factor
dk$Kinetic_key <- as.character(dk$Kinetic_key)
dk <- arrange(dk, Kinetic_key)
dk$Kinetic_key <- as.factor(dk$Kinetic_key)

# Clean the R environment
rm(dd, dt, df)

# Save the raw kinetics data
save.image(file = "Kinetics_data.RData")
