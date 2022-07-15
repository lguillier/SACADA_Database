##### This R script enables to estimate the value of D from all raw kinetics data previously collected

#### Packages ####
library(ggplot2)

#### Load all raw kinetics data ####
load(file="Kinetics_data.RData")


#### Estimation of D ####
##### Function to automatize the procedure #####
f_estimate_Dvalues = function(dk) {
  ## This function enables to automatized the estimation of D by fitting linear inactivation model for each kinetics
  ## INTPUT
  ##  dk (data.frame) data frame with at least the following columns
  ##    $ Kinetics_key (factor/character): ID of the kinetics
  ##    $ time_hours (numeric): experimental time points (in hour)
  ##    $ y (numeric): measured of the viral concentration in log10 scale
  ## OUTPUT
  ##    - output (list)
  ##      $ regplot (list) list of de linear regression plot for each kinetics, e.g.:
  ##          $ K102 (ggplot2 object) regression plot for the kinetics K102
  ##          $ K103 (ggplot2 object) regression plot for the kinetics K103
  ##          ...
  ##      $ Dvalues_tab (dataframe) estimated values of log10(D) for each kinetics
  ##          $ Kinetics_key (character): ID of the kinetics
  ##          $ log10Dvalues (numeric): estimated value of log10(D)
  
  # Total number of kinetics in the data frame dk
  nb_kinetics = length(levels(dk$Kinetics_key)) 
  
  ## Initialize the output objects
  # Dvalues_tab
  Dvalues_tab <- data.frame(Kinetics_key = levels(dk$Kinetics_key),
                            #y_variable = rep(NA, nb_kinetics),
                            nb_points = rep(NA, nb_kinetics),
                            Dvalues = rep(NA, nb_kinetics),
                            Dvalues_stderr = rep(NA, nb_kinetics),
                            Dvalues_CV = rep(NA, nb_kinetics))
  # regplot
  regplot <- list()
  
  # Automatic estimation of D
  for (i in 1:nb_kinetics) { # for each kinetics
    # extract the kinetics key
    Kinetic_i <- levels(dk$Kinetics_key)[i]
    
    # console check
    writeLines(paste("kinetics", Kinetic_i))
    
    # extract the data associated with the considered kinetics
    tab_Kinetic_i <- subset(dk, Kinetics_key == Kinetic_i)
    
    # total number of available points associated with the considered kinetics
    nb_points_i <- sum(!is.na(tab_Kinetic_i$y))
    
    # save the kinetics keys and number of points in the output data frame
    Dvalues_tab$Kinetics_key[i] <- Kinetic_i
    Dvalues_tab$nb_points[i] <- nb_points_i
    
    # save the regression plot associated with the considered kinetics
    regplot[[Kinetic_i]] <- ggplot(data = tab_Kinetic_i,
                                   mapping = aes(x = time_hours, y = y)) +
      geom_point(shape = 18, size=3) +
      geom_smooth(formula = y~x, method = lm, colour = "black") +
      theme(axis.ticks=element_blank(),
            axis.title = element_text(face="bold", size=14),
            panel.background=element_rect(fill="white"),
            panel.grid=element_line(colour="grey")) +
      labs(title = paste("Kinetics key:", Kinetic_i)) +
      xlab("time (hours)") + ylab("y")
    
    
    ## Estimation of D for each kinetics by fitting log-linear regression model on data
    skip_to_next <- FALSE
    tryCatch({
      model_i <- nls(data = tab_Kinetic_i,
                     formula = y ~ b - (time_hours/D_value),
                     start = list(b = tab_Kinetic_i$y[1],
                                  D_value = -1/lm(data = tab_Kinetic_i, 
                                                  formula = y ~ time_hours)$coefficients[2]),
                     algorithm = "port")
      
      # extract the estimated values of D and its standard error
      Dvalues_i <- summary(model_i)$coefficients[2,1]
      Dvalues_stderr_i <- summary(model_i)$coefficients[2,2]
      
      # save estimated values in the output data frame Dvalues_tab
      Dvalues_tab$Dvalues[i] <- abs(Dvalues_i)
      Dvalues_tab$Dvalues_stderr[i] <- Dvalues_stderr_i
      Dvalues_tab$Dvalues_CV[i] <- Dvalues_stderr_i / abs(Dvalues_i)
    }, error = function(e) { skip_to_next <<- TRUE})
    
    if(skip_to_next) { next }  

  }
  
  ## Prepare the output object (regression plots and data frame of estimated values)
  output <- list("regplot" = regplot,
                 "Dvalues_tab" = Dvalues_tab)
  
  return(output)
}

##### Estimation of D: automatic run #####
D <- f_estimate_Dvalues(dk)




##### Processing non-convergence cases #####
###### K009 #####
key <- "K009"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K009
#-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = d$y[1],
                              D_value = 10),
                 algorithm = "port")

D$Dvalues_tab[row_id,]$Dvalues <- summary(model_nls)$coefficients[2,1]
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / abs(summary(model_nls)$coefficients[2,1])

##### K013 #####
key <- "K013"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K013
#-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = 0,
                              D_value = 5),
                 algorithm = "port")
#summary(model_nls)
D$Dvalues_tab[row_id,]$Dvalues <- summary(model_nls)$coefficients[2,1]
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / abs(summary(model_nls)$coefficients[2,1])

#### K016 ####
key <- "K016"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K016
#-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = 0,
                              D_value = 5),
                 algorithm = "port")
#summary(model_nls)
D$Dvalues_tab[row_id,]$Dvalues <- summary(model_nls)$coefficients[2,1]
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / abs(summary(model_nls)$coefficients[2,1])


#### K018 ####
key <- "K018"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K018
#-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = 0,
                              D_value = 5),
                 algorithm = "port")
#summary(model_nls)
D$Dvalues_tab[row_id,]$Dvalues <- summary(model_nls)$coefficients[2,1]
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / abs(summary(model_nls)$coefficients[2,1])

#### K019 ####
key <- "K019"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K019
#-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = 0,
                              D_value = 5),
                 algorithm = "port")
#summary(model_nls)
D$Dvalues_tab[row_id,]$Dvalues <- summary(model_nls)$coefficients[2,1]
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / abs(summary(model_nls)$coefficients[2,1])

#### K029 ####
key <- "K029"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K029
#-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = 0,
                              D_value = 5),
                 algorithm = "port")
#summary(model_nls)
D$Dvalues_tab[row_id,]$Dvalues <- summary(model_nls)$coefficients[2,1]
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / abs(summary(model_nls)$coefficients[2,1])

#### K037 ####
key <- "K037"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K037
#-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = 0,
                              D_value = 5),
                 algorithm = "port")
summary(model_nls)
D$Dvalues_tab[row_id,]$Dvalues <- summary(model_nls)$coefficients[2,1]
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / abs(summary(model_nls)$coefficients[2,1])

#### K039 ####
key <- "K039"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K039
#-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = 0,
                              D_value = 5),
                 algorithm = "port")
summary(model_nls)
D$Dvalues_tab[row_id,]$Dvalues <- summary(model_nls)$coefficients[2,1]
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / abs(summary(model_nls)$coefficients[2,1])

#### K089 ####
key <- "K089"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K089
#-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = 0,
                              D_value = 5),
                 algorithm = "port")
summary(model_nls)
D$Dvalues_tab[row_id,]$Dvalues <- summary(model_nls)$coefficients[2,1]
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / abs(summary(model_nls)$coefficients[2,1])

#### K128 ####
key <- "K128"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K128 ## 1 point ! --> Dvalue not estimated

#### K148 ####
key <- "K148"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K148 ## 1 point ! --> Dvalue not estimated

#### K185 ####
key <- "K185"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K185 ## 1 point --> Dvalue not estimated

#### K238 ####
key <- "K238"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K238 ## 3 points en "horizontal" ! --> Dvalue not estimated

#### K267 ####
key <- "K267"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K267
-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = 2,
                              D_value = -10),
                 algorithm = "port")
#summary(model_nls)
D$Dvalues_tab[row_id,]$Dvalues <- abs(summary(model_nls)$coefficients[2,1])
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / abs(summary(model_nls)$coefficients[2,1])

#### K274 ####
key <- "K274"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K274
-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = 2,
                              D_value = -10),
                 algorithm = "port")
summary(model_nls)
D$Dvalues_tab[row_id,]$Dvalues <- abs(summary(model_nls)$coefficients[2,1])
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / abs(summary(model_nls)$coefficients[2,1])

#### K275 ####
key <- "K275"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K275
-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = 2,
                              D_value = -10),
                 algorithm = "port")
summary(model_nls)
D$Dvalues_tab[row_id,]$Dvalues <- abs(summary(model_nls)$coefficients[2,1])
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / abs(summary(model_nls)$coefficients[2,1])

#### K276 ####
key <- "K276"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K276
-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = 2,
                              D_value = -10),
                 algorithm = "port")
summary(model_nls)
D$Dvalues_tab[row_id,]$Dvalues <- abs(summary(model_nls)$coefficients[2,1])
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / abs(summary(model_nls)$coefficients[2,1])

#### K279 ####
key <- "K279"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K279
-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = 2,
                              D_value = -10),
                 algorithm = "port")
summary(model_nls)
D$Dvalues_tab[row_id,]$Dvalues <- abs(summary(model_nls)$coefficients[2,1])
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / abs(summary(model_nls)$coefficients[2,1])

#### K418 ####
key <- "K418"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K418
-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = 2,
                              D_value = 100),
                 algorithm = "port")
#summary(model_nls)
D$Dvalues_tab[row_id,]$Dvalues <- summary(model_nls)$coefficients[2,1]
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / summary(model_nls)$coefficients[2,1]

#### K460 ####
key <- "K460"
row_id <- which(D$Dvalues_tab$Kinetics_key == key)
d <- subset(dk, Kinetics_key==key)
#D$regplot$K460 ## regression plots
-1/lm(data = d, formula = y ~ time_hours)$coefficients[2] 
model_nls <- nls(data = d, formula = y ~ b - (time_hours/D_value),
                 start = list(b = 2,
                              D_value = 200),
                 algorithm = "port")
#summary(model_nls)
D$Dvalues_tab[row_id,]$Dvalues <- summary(model_nls)$coefficients[2,1]
D$Dvalues_tab[row_id,]$Dvalues_stderr <- summary(model_nls)$coefficients[2,2]
D$Dvalues_tab[row_id,]$Dvalues_CV <- summary(model_nls)$coefficients[2,2] / summary(model_nls)$coefficients[2,1]


#### Calculate log10(D) ####
D$Dvalues_tab <- mutate(D$Dvalues_tab, log10D = log10(Dvalues))



# Clear the environment #
rm(d, model_nls, key, row_id, f_estimate_Dvalues)



# Save data with estimated values of D
save.image("Dvalues_data.RData")
