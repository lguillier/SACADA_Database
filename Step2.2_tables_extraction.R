## This R script enables to extract raw data gathered in the Excel raw data spreadsheet

#### Extract raw data from each study #####
Table_Batejat2020 <- read_excel(RawData_FileName, sheet = "Table_Batejat2020")

Table_Behzadinasab2020_S <- read_excel(RawData_FileName, sheet = "Table_Behzadinasab2020_S")

Table_Chin2020_A <- read_excel(RawData_FileName, sheet = "Table_Chin2020_A")
Table_Chin2020_B <- read_excel(RawData_FileName, sheet = "Table_Chin2020_B")

Table_Dai2020_SuppTable <- read_excel(RawData_FileName, sheet = "Table_Dai2020_SuppTable")

Table_Fukuta2021_1 <- read_excel(RawData_FileName, sheet = "Table_Fukuta2021_1")

Table_Hulst2019_3 <- read_excel(RawData_FileName, sheet = "Table_Hulst2019_3")

Table_Kasloff2020_2 <- read_excel(RawData_FileName, sheet = "Table_Kasloff2020_2")

Table_Leclercq2014_1 <- read_excel(RawData_FileName, sheet = "Table_Leclercq2014_1")

Table_Lee2020 <- read_excel(RawData_FileName, sheet = "Table_Lee2020")

Table_Malenovska2020_2 <- read_excel(RawData_FileName, sheet = "Table_Malenovska2020_2")

Table_Marugano2021 <- read_excel(RawData_FileName, sheet = "Table_Marugano2021")

Table_OCLC2020_2 <- read_excel(RawData_FileName, sheet = "Table_OCLC2020_2")
Table_OCLC2020_3 <- read_excel(RawData_FileName, sheet = "Table_OCLC2020_3")
Table_OCLC2020_4 <- read_excel(RawData_FileName, sheet = "Table_OCLC2020_4")
Table_OCLC2020_5 <- read_excel(RawData_FileName, sheet = "Table_OCLC2020_5")
Table_OCLC2020_6 <- read_excel(RawData_FileName, sheet = "Table_OCLC2020_6")
Table_OCLC2020_7_8 <- read_excel(RawData_FileName, sheet = "Table_OCLC2020_7_8")
Table_OCLC2020 <- rbind(Table_OCLC2020_2, Table_OCLC2020_3, Table_OCLC2020_4,
                        Table_OCLC2020_5, Table_OCLC2020_6, Table_OCLC2020_7_8)

Table_Pastorino2020 <- read_excel(RawData_FileName, sheet = "Table_Pastorino2020")

Table_Rabenau2005_1 <- read_excel(RawData_FileName, sheet = "Table_Rabenau2005_1")

Table_Ronca2021_2 <- read_excel(RawData_FileName, sheet = "Table_Ronca2021_2")

Table_Saknimit1988_3 <- read_excel(RawData_FileName, sheet = "Table_Saknimit1988_3")








#### Combining data from all tables in a unique data frame ####
# dt: (data frame) with 4 columns: Kinetics_key, time_hours, y_variable (name of y) and y (measured values)
dt <- data.frame(Kinetics_key = c(Table_Batejat2020$Kinetics_key,
                                 Table_Behzadinasab2020_S$Kinetics_key,
                                 Table_Chin2020_A$Kinetics_key, 
                                 Table_Chin2020_B$Kinetics_key,
                                 Table_Dai2020_SuppTable$Kinetics_key,
                                 Table_Fukuta2021_1$Kinetics_key,
                                 Table_Hulst2019_3$Kinetics_key,
                                 Table_Kasloff2020_2$Kinetics_key,
                                 Table_Leclercq2014_1$Kinetics_key,
                                 Table_Lee2020$Kinetics_key,
                                 Table_Malenovska2020_2$Kinetics_key,
                                 Table_Marugano2021$Kinetics_key,
                                 Table_OCLC2020$Kinetics_key,
                                 Table_Pastorino2020$Kinetics_key,
                                 Table_Rabenau2005_1$Kinetics_key,
                                 Table_Ronca2021_2$Kinetics_key,
                                 Table_Saknimit1988_3$Kinetics_key),
                 time_hours = c(Table_Batejat2020$time_hours,
                                Table_Behzadinasab2020_S$time_hours,
                                Table_Chin2020_A$time_hours, 
                                Table_Chin2020_B$time_hours,
                                Table_Dai2020_SuppTable$time_hours,
                                Table_Fukuta2021_1$time_hours,
                                Table_Hulst2019_3$time_hours,
                                Table_Kasloff2020_2$time_hours,
                                Table_Leclercq2014_1$time_hours,
                                Table_Lee2020$time_hours,
                                Table_Malenovska2020_2$time_hours,
                                Table_Marugano2021$time_hours,
                                Table_OCLC2020$time_hours,
                                Table_Pastorino2020$time_hours,
                                Table_Rabenau2005_1$time_hours,
                                Table_Ronca2021_2$time_hours,
                                Table_Saknimit1988_3$time_hours),
                 y_variable = c(rep("logTCID50_ml", nrow(Table_Batejat2020)),
                                rep("logTCID50_ml", nrow(Table_Behzadinasab2020_S)),
                                rep("logTCID50_ml", nrow(Table_Chin2020_A)),
                                rep("logTCID50_ml", nrow(Table_Chin2020_B)),
                                rep("logTCID50_ml", nrow(Table_Dai2020_SuppTable)),
                                rep("logPFU_ml", nrow(Table_Fukuta2021_1)),
                                rep("LRF", nrow(Table_Hulst2019_3)),
                                rep("logTCID50_ml", nrow(Table_Kasloff2020_2)),
                                rep("logTCID50_ml", nrow(Table_Leclercq2014_1)),
                                rep("logPFU_ml", nrow(Table_Lee2020)),
                                rep("logTCID50_ml", nrow(Table_Malenovska2020_2)),
                                rep("logTCID50_ml", nrow(Table_Marugano2021)),
                                rep("logTCID50_ml", nrow(Table_OCLC2020)),
                                rep("logTCID50_ml", nrow(Table_Pastorino2020)),
                                rep("logTCID50_ml", nrow(Table_Rabenau2005_1)),
                                rep("log10(PFU_2cm2)", nrow(Table_Ronca2021_2)),
                                rep("decrease_logPFU_0.1ml", nrow(Table_Saknimit1988_3))),
                 y = c(Table_Batejat2020$logTCID50_ml,
                       Table_Behzadinasab2020_S$logTCID50_ml,
                       Table_Chin2020_A$logTCID50_ml, 
                       Table_Chin2020_B$logTCID50_ml,
                       Table_Dai2020_SuppTable$logTCID50_ml,
                       Table_Fukuta2021_1$logPFU_ml,
                       Table_Hulst2019_3$LRF,
                       Table_Kasloff2020_2$logTCID50_ml,
                       Table_Leclercq2014_1$logTCID50_ml,
                       Table_Lee2020$logPFU_ml,
                       Table_Malenovska2020_2$logTCID50_ml,
                       Table_Marugano2021$logTCID50_ml,
                       Table_OCLC2020$logTCID50_ml,
                       Table_Pastorino2020$logTCID50_ml,
                       Table_Rabenau2005_1$logTCID50_ml,
                       log10(Table_Ronca2021_2$PFU_2cm2+1),
                       Table_Saknimit1988_3$decrease_logPFU_0.1ml)
)

# Clean the environment by remove intermediate tables
rm(Table_Batejat2020,
   Table_Behzadinasab2020_S, 
   Table_Chin2020_A,
   Table_Chin2020_B,
   Table_Dai2020_SuppTable,
   Table_Fukuta2021_1,
   Table_Hulst2019_3,
   Table_Kasloff2020_2,
   Table_Leclercq2014_1,
   Table_Lee2020,
   Table_Malenovska2020_2,
   Table_Marugano2021,
   Table_OCLC2020, 
   Table_OCLC2020_2,
   Table_OCLC2020_3,
   Table_OCLC2020_4,
   Table_OCLC2020_5,
   Table_OCLC2020_6, 
   Table_OCLC2020_7_8,
   Table_Pastorino2020,
   Table_Rabenau2005_1,
   Table_Ronca2021_2,
   Table_Saknimit1988_3)
