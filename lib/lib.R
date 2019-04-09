# Packages for analysis

# User-Written Functions
source(here("lib", "function_ci.R"))
source(here("lib", "function_summary.R"))
source(here("lib", "function_model-fit-contrasts.R"))

# Data
library(readxl)
library(tidyverse)

# Modeling
library(MASS) # standard NB
library(pscl) # zero inflated
library(car) # delta method

# Tables
library(xtable) # generating draft tables
library(qwraps2)
library(epiDisplay)
library(epiR)
library(summarytools)

# General Plotting 
library(ggridges) 
library(ggthemr)
ggthemr(palette = "fresh", layout = "clear")
library(latex2exp)
library(gridExtra)
library(grid)
library(countreg) # rootogram

