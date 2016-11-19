# INITIAL SETUP:
# Do not edit unless you know what you are doing!

# The following line is commented out for portability…
# Make sure you are in the correct working directory!
# setwd("~/Documents/Rworkspace/orfweather")  # Ensure correct working directory
library(dplyr)  # Library for data wrangling
library(Hmisc)  # Load library required for minor tick marks
source("orfwxfunctions.R")  # Include function file.
# END INITIAL SETUP

# CONFIGURATION
# Change the following with up-to-date information
currentDate <- searchDate(11, 17)   # use searchDate() for the current Date
                              # otherwise, put the month and day of
                              # month in quotes (with leading
                              # zeroes), e.g. searchdate("10", "02")
                              # for October 2nd.

# Add the high & low temperatures and precipitation total for the day.
todaysHigh <- 61
todaysLow <- 42
todaysPrecipitation <- 0.00
# END CONFIGURATION
