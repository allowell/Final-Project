

#Loading in the packages
library(plumber)
library(dplyr)
library(tidyverse)

#Reading in the data
diab_data <- read_csv("diabetes_binary_health_indicators_BRFSS2015.csv")
diab_data <- diab_data |>
  #Converting a few variables of interest to factor
  mutate(Diabetes_binary = as_factor(Diabetes_binary),
         HighBP = as_factor(HighBP),
         HighChol = as_factor(HighChol),
         Smoker = as_factor(Smoker),
         Sex = as_factor(Sex),
         Age = as_factor(Age)
  ) |>
  #Removing any rows with NA
  drop_na()

#Fit best model: logistic regression



#Creating the function
