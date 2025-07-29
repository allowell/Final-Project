

#Loading in the packages
library(plumber)
library(dplyr)
library(tidyverse)

#Reading in the data
diab_data <- read_csv("diabetes_binary_health_indicators_BRFSS2015.csv")

#Fit best model: random forest
RF_wkf_API <- readRDS("RF_wkf.rds")

#Setting initial default values
def_Age <- names(which.max(table(diab_data$Age)))
def_HighBP <- factor(as.numeric(names(which.max(table(diab_data$HighBP)))))
def_BMI <- mean(diab_data$BMI)


#Creating the function
#* Predicting from Random Forest Model
#* @param Age
#* @param HighBP
#* @param BMI
#* @get /predict
function(Age = def_Age, HighBP = def_HighBP, BMI = def_BMI){
  
  pred_data <- data.frame(
    Age = as_factor(Age),
    HighBP = as_factor(HighBP),
    BMI = as.numeric(BMI)
  )
  
  prediction <- predict(RF_wkf_API, pred_data, type = "prob")
  return(prediction)
}


#Making info endpoint
#* Info endpoint
#* @get /info
function() {
  list(
    name = "Allison McDowell",
    github_site = "https://github.com/allowell/Final-Project")
}








