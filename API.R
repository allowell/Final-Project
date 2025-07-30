

#Loading in the packages
library(plumber)
library(dplyr)
library(tidyverse)
library(tidymodels)
library(ranger)

#Reading in the data
diab_data <- read_csv("diabetes_binary_health_indicators_BRFSS2015.csv")

#Fit best model: random forest
#Loading this in, also in hopes this works on my main Mac machine
RF_wkf_API <- readRDS("RF_wkf.rds")

#Setting initial default values
def_Age <- names(which.max(table(diab_data$Age)))
def_HighBP <- as.numeric(names(which.max(table(diab_data$HighBP))))
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


#3 example function calls to the API

#Example 1: default
#http://127.0.0.1:27504/predict

#Example 2: info
#http://127.0.0.1:27504/info

#Example 3: change highbp to 1, age to 10, BMI to 30
#http://127.0.0.1:27504/predict?Age=10&HighBP=1&BMI=30









