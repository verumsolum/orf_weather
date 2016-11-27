# INITIAL SETUP:
# Do not edit unless you know what you are doing!

library(dplyr)  # Library for data wrangling
library(Hmisc)  # Load library required for minor tick marks
library(orfwx)  # Load the weather functions
# END INITIAL SETUP

# CONFIGURATION
# Change the following with up-to-date information
currentDate <- searchDate(11, 27)   # use searchDate() for the current Date
                                    # otherwise, pass the month and day of
                                    # month in quotes, e.g. searchdate(10, 2)
                                    # for October 2nd.

# Add the high & low temperatures and precipitation total for the day.
todaysHigh <- 54
todaysLow <- 46
todaysPrecipitation <- 0.03
# END CONFIGURATION
