# NOTE: Run this file from the data-raw directory to create data objects.

library(utils)
library(dplyr, warn.conflicts = FALSE)
library(devtools)

# Read Norfolk airport weather data from CSV
airportData <- read.csv(
  "NorfolkIntlAp.csv",
  colClasses = c("Date",
                 "integer",
                 "integer",
                 "numeric",
                 "character",
                 "character"),
  strip.white = TRUE,
  na.strings = c("M", NULL)
)
downtownData <- read.csv(
  "NorfolkWbCity.csv",
  colClasses = c("Date",
                 "integer",
                 "integer",
                 "numeric",
                 "character",
                 "character"),
  strip.white = TRUE,
  na.strings = c("M", NULL)
)

# Rename Precipitation and Snowfall variables, so we don't have to do it later
airportData <- dplyr::rename(airportData,
                             CsvPrecipitation = Precipitation,
                             CsvSnowfall = Snowfall)
downtownData <- dplyr::rename(downtownData,
                              CsvPrecipitation = Precipitation,
                              CsvSnowfall = Snowfall)

# Remove duplicate dates (only use downtown before 1946-01-01)
earlyDowntownData <-
  downtownData[which(downtownData$Date < as.Date("1946-01-01")),]
bothStations <- rbind(airportData, earlyDowntownData)
bothStations <- dplyr::arrange(bothStations, Date)

# Save these as data.
devtools::use_data(airportData, overwrite = TRUE)
devtools::use_data(earlyDowntownData, overwrite = TRUE)
devtools::use_data(bothStations, overwrite = TRUE)
# devtools::use_data(mutatedBothStations, overwrite = TRUE)
