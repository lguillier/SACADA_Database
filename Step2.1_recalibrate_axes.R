# The following R scripts enables to re-assign correct x values digitalized from different publications

#### Bonny2018 #####
dd$scatterplot$Fig_Bonny2018_1.png$x <- c(0,24,48,72,96,120,144,168, #K360: 8 points
                                          0,24,48,72,96,120,144,168, #K361: 8 points
                                          0,24,48,72,96,120,144,168) #K362: 8 points

#### BlondinBrosseau2021 (2 figures, 4 kinetics) ####
dd$scatterplot$Fig_BlondinBrosseau2021_1.png$x <- c(0,0.5,1,2,4,6,16, #K239: 7 points
                                                    0,0.5,1,2,4,6,16, #K230: 7 points
                                                    0,0.5,1,2,4,6,16,24,48,72) #K231: 10 points
dd$scatterplot$Fig_BlondinBrosseau2021_2.png$x <- c(0,24,48,72) #K232: 4 points

#### Casanova2010b (1 figure, 4 kinetics) ####
dd$scatterplot$Fig_Casanova2010b$x <- c(0,2,4,24, #K423: 4 points
                                        0,2,4,24, #K424: 4 points
                                        0,2,4,24, #K425: 4 points
                                        0,2,4,24) #K426: 4 points

#### Chan2011 (3 figures, 7 kinetics) ####
dd$scatterplot$Fig_Chan2011_1.png$x <- c(0,3,7,11,13,24,48,72,120,168,312,504,672, #K227: 13 points
                                         0,3,7,11,13,24,48,72,120,168,312,504,672) #K228: 13 points
dd$scatterplot$Fig_Chan2011_2a.JPG$x <- c(3,7,11,13,24, #K057: 5 points
                                          3,7,11,13,24, #K058: 5 points
                                          3,7,11,13,24) # K059: 5 points
dd$scatterplot$Fig_Chan2011_2b.png$x <- c(3,7,11,13,24, #K060: 5 points
                                          3,7,11,13,24) # K061: 5 points

#### Harbourt2020 (4 figures, 12 kinetics): from K143 to K154 ####
## Fig_Harbourt2020_2A, Fig_Harbourt2020_2B, Fig_Harbourt2020_2C, Fig_Harbourt2020_2D
dd$scatterplot$Fig_Harbourt2020_2A.png$x <- c(0,4,8,24,72,96,168,336, #K143: 8 points
                                              0,4,8,24, #K144: 4 points
                                              0,4) #K145:2 points
dd$scatterplot$Fig_Harbourt2020_2B.png$x <- c(0,4,8,24,72,96, #K146: 6 points
                                              0,4,#K147: 2 points
                                              0) #K145:1 point
dd$scatterplot$Fig_Harbourt2020_2C.png$x <- c(0,4,8,24,72,96, #K149: 6 points
                                              0,4,8, #K150: 3 points
                                              0,4) #K151:2 points
dd$scatterplot$Fig_Harbourt2020_2D.png$x <- c(0,4,8,24,72, #K152: 5 points
                                              0,4,8, #K153: 3 points
                                              0,4) #K154:2 points

#### Kratzel2020 (3 figures, 3 kinetics): from K155 to K157 ####
## Fig_Kratzel2020_1A_4,  Fig_Kratzel2020_1A_RT,  Fig_Kratzel2020_1A_30
dd$scatterplot$Fig_Kratzel2020_1A_4.png$x <- c(1,4,8,24,48,72,96,120,144,168,192,214) #K155: 12 points
dd$scatterplot$Fig_Kratzel2020_1A_RT.png$x <- c(1,4,8,24,48,72,120) #K156: 7 points
dd$scatterplot$Fig_Kratzel2020_1A_30.png$x <- c(1,4,8,24,48,72,96,120,144,168,192,214) #K157: 12 points

#### Lai2005 (2 figures, 9 kinetics) ####
dd$scatterplot$Fig_Lai2005_1.JPG$x <- c(0,0.5,1,3,6,24,48,96,120,144,168, ##K062: 11 points
                                        0,0.5,1,3, #K241: 4 points
                                        0,0.5,1,3,6, #K242: 5 points
                                        0,0.5,1,3,6,24, #K243: 6 points
                                        0,0.5,1,3,6,24,48,96,120) #K244: 9 points
dd$scatterplot$Fig_Lai2005_2.jpg$x <- c(0,3,6,24,72,96,120,168, #K063: 8 points
                                        0,3,6,24,72,96,120,168, #K064: 8 points
                                        0,3,6,24,72,96,120,168,240, #K065: 9 points
                                        0,3,6,24,72,96,120,168,240,264,288,336,432,456,480,504,576,648) #K066: 18 points

#### Liu2021 (9 figures, 9 kinetics): from K172 to K180 ####
dd$scatterplot$Fig_Liu2021_1A_Plastic.png$x <- c(0,1,2,6,24,48,72,96,120,168) #K172: 10 points
dd$scatterplot$Fig_Liu2021_1A_StainlessSteel.png$x <- c(0,1,2,6,24,48,72,96,120,168) #K173: 10 points
dd$scatterplot$Fig_Liu2021_1A_Glass.png$x <- c(0,1,2,6,24,48,72,96,120,168) #K174: 10 points
dd$scatterplot$Fig_Liu2021_1A_Ceramics.png$x <- c(0,1,2,6,24,48,72,96,120,168) #K175: 10 points
dd$scatterplot$Fig_Liu2021_1A_SurgicalMask.png$x <- c(0,1,2,6,24,48,72,96,120,168) #K176: 10 points
dd$scatterplot$Fig_Liu2021_1A_LatexGloves.png$x <- c(0,1,2,6,24,48,72,96,120,168) #K177: 10 points
dd$scatterplot$Fig_Liu2021_1A_CottonClothes.png$x <- c(0,1,2,6,24,48,72,96,120,168) #K178: 10 points
dd$scatterplot$Fig_Liu2021_1A_Wood.png$x <- c(0,1,2,6,24,48,72,96,120,168) #K179: 10 points
dd$scatterplot$Fig_Liu2021_1A_Paper.png$x <- c(0,1,2,6,24,48,72,96,120,168) #K180: 10 points

#### Mullis 2012 (2 figures, 2 kinetics) ####
dd$scatterplot$Fig_Mullis2012_2A.JPG$x <- c(0,48,120,168,288,336,480,600) # K101: 8 points
dd$scatterplot$Fig_Mullis2012_2B.JPG$x <- c(0,48,120,168,288,336,480,600,720) # K102: 9 points

#### Rabenau2005 ####
dd$scatterplot$Fig_Rabeneau2005_2a.png$x <- c(0,24,48,72,144,216, #K219: 6 points
                                              0,24,48,72) #K221: 4 points 
dd$scatterplot$Fig_Rabeneau2005_2b.png$x <- c(0,24,48,72,144,216, #K220: 6 points
                                              0,24,48) #K222: 3 points 
dd$scatterplot$Fig_Rabeneau2005_2c.png$x <- c(0,24,48,72,144,216, #K007: 6 points
                                              0,24,48,72,144,216) #K080: 6 points 
dd$scatterplot$Fig_Rabeneau2005_2d.png$x <- c(0,24,48,72,144,216, #K008: 6 points
                                              0,24,48,72,144,216) #K081: 6 points 

#### SalaComorera2021 ####
dd$scatterplot$Fig_SalaComorera2021_1.png$x <- c(0,4,8,24,48,72,96,120,144,192,240, #K308: 11 points
                                                 0,4,8,24,48,72,96,120, #K309: 8 points
                                                 0,4,8,24,48,72,96,120, #K310: 8 points
                                                 0,4,8,24,48,72) #K311: 6 points

#### Sizun2020 ####
dd$scatterplot$Fig_Sizun2020_1a.png$y <- log10(abs(dd$scatterplot$Fig_Sizun2020_1a.png$y))
dd$scatterplot$Fig_Sizun2020_1b.png$y <- log10(abs(dd$scatterplot$Fig_Sizun2020_1b.png$y))
dd$scatterplot$Fig_Sizun2020_1b.png$y[8] <- 0

#### Ahmed2020 ####
dd$scatterplot$Fig_Ahmed2020_1.png$y <- dd$scatterplot$Fig_Ahmed2020_1.png$y * log10(exp(1))
dd$scatterplot$Fig_Ahmed2020_1.png$y_variable <- rep("log10_Ct_C0",
                                                     length(dd$scatterplot$Fig_Ahmed2020_1.png$y_variable))
dd$scatterplot$Fig_Ahmed2020_1_AutoclavedWastewater.png$y <- dd$scatterplot$Fig_Ahmed2020_1_AutoclavedWastewater.png$y * log10(exp(1))
dd$scatterplot$Fig_Ahmed2020_1_AutoclavedWastewater.png$y_variable <- rep("log10_Ct_C0",
                                                     length(dd$scatterplot$Fig_Ahmed2020_1_AutoclavedWastewater.png$y_variable))
dd$scatterplot$Fig_Ahmed2020_1_Tapwater.png$y <- dd$scatterplot$Fig_Ahmed2020_1_Tapwater.png$y * log10(exp(1))
dd$scatterplot$Fig_Ahmed2020_1_Tapwater.png$y_variable <- rep("log10_Ct_C0",
                                                     length(dd$scatterplot$Fig_Ahmed2020_1_Tapwater.png$y_variable))






