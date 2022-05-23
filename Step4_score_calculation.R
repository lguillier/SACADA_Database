# This script was used to calculate the ranking score for each kinetic previously collected based on different criteria

#### Packages ####
library(metaDigitise)
library(readxl)
library(dplyr)
library(doBy)

# Set the working directory at the current location of this R script
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#### Load data with estimated values of D ####
# Check the script 'extimated_Dvalues.R' for details if needed
load("Dvalues_data.RData")


#### Import the metadata ####
metadata <- read_excel(path = RawData_FileName, # check the file name of the Excel spreadsheet here
                            sheet = "Metadata")

#### Full dataset ####
# Combine the estimated values of D into the metadata table: dataframe DATASET
D$Dvalues_tab <- dplyr::arrange(D$Dvalues_tab, Kinetic_key)
metadata <- dplyr::arrange(metadata, Kinetic_key)

DATASET <- cbind(metadata, 
                 dplyr::select(D$Dvalues_tab, -c("Kinetic_key")))




#### Calculate the ranking scores ####
DATASET$Replicate <- as.factor(DATASET$Replicate)

##### Score s1 based on the total number of time points #####
s1 <- rep(NA, nrow(DATASET))

for (i in 1:nrow(DATASET)) { # for each kinetic: assign a score for different categories 
  if (DATASET$nb_points[i] <= 3) {s1[i] <- 1}
  else {
    if (DATASET$nb_points[i] >= 4 & DATASET$nb_points[i] <= 5) {s1[i] <- 2}
    else {
      if (DATASET$nb_points[i] >= 6 & DATASET$nb_points[i] <= 7) {s1[i] <- 3}
      else {s1[i] <- 4}
    }
  }
}

##### Score s2 based on the type of the points (unique/multiple replicate) #####
s2 <- rep(NA, nrow(DATASET))

for (i in 1:nrow(DATASET)) { 
  if (DATASET$Replicate[i] == "Unique") {s2[i] <- 1}
  else {s2[i] <- 3}
}

##### Score s3 based on coefficient of variation #####
s3 <- rep(NA, nrow(DATASET))

for (i in 1:nrow(DATASET)) { ## pour chaque cinetique
  if (is.na(DATASET$Dvalues_CV[i]) == T) {s3[i] <- 1}
  else {
    if (DATASET$Dvalues_CV[i] <= 0.1) {s3[i] <- 4}
    else {
      if (DATASET$nb_points[i] > 0.1 & DATASET$nb_points[i] <= 0.2) {s3[i] <- 3}
      else {
        if (DATASET$nb_points[i] > 0.2 & DATASET$nb_points[i] <= 0.3) {s3[i] <- 2}
        else {s3[i] <- 1}
      }
    }
  }
}

##### Global score combining s1, s2 and s3 #####
S <- s1*s2+s3

DATASET <- DATASET %>%
  dplyr::mutate(s1 = s1,
         s2 = s2,
         s3 = s3,
         S = S)


#### Preparing the output RData object ####
regplot <- D$regplot
kinetics_rawdata <- dk

# Clean the global environment
rm(D,s1,s2,s3,S,i,dk,RawData_FileName,metadata)




#### OUTPUT RDATA OBJECT ####
save.image("DATASET.RData")


#### EXPORT THE FULL DATASET AS EXCEL SPREADSHEET #####
openxlsx::write.xlsx(DATASET, file = "DataRecords_OuputData.xlsx")
