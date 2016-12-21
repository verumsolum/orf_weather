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
# mutatedBothStations <- dplyr::mutate(
#   bothStations,
#   MaxTemperature = as.integer(MaxTemperature),
#   MinTemperature = as.integer(MinTemperature)
# )
# mutatedBothStations <- dplyr::tbl_df(mutatedBothStations)
# mutatedBothStations <- dplyr::mutate(
#   mutatedBothStations,
#   leapYearAwareDayOfYear = ifelse(Month > 3 & !orfwx::is.leapYear(Year), 
#                                   DayOfYear + 1, 
#                                   DayOfYear)
# )
# 
# # Create two new variables from CsvPrecipitation
# mutatedBothStations <- dplyr::mutate(
#   mutatedBothStations,
#   PrecipitationInches = dplyr::if_else(is.na(CsvPrecipitation),
#                                        NA_real_,
#                                        dplyr::if_else(CsvPrecipitation == "T",
#                                                       0,
#                                                       as.numeric(as.character(
#                                                         CsvPrecipitation)))),
#   WithPrecipitation = dplyr::if_else(is.na(CsvPrecipitation),
#                                      NA,
#                                      dplyr::if_else(CsvPrecipitation == "T",
#                                                     TRUE,
#                                                     as.logical(
#                                                       PrecipitationInches))))
# 
# # Rename Snowfall -> CsvSnowfall
# mutatedBothStations <- dplyr::mutate(mutatedBothStations, 
#                                      CsvSnowfall = Snowfall) %>%
#   select(-Snowfall)
# 
# # Create two new variables from CsvSnowfall
# mutatedBothStations <- dplyr::mutate(
#   mutatedBothStations,
#   SnowfallInches = dplyr::if_else(is.na(CsvSnowfall),
#                                   NA_real_,
#                                   dplyr::if_else(CsvSnowfall == "T",
#                                                  0,
#                                                  as.numeric(as.character(
#                                                    CsvSnowfall)))),
#   WithSnowfall = dplyr::if_else(is.na(CsvSnowfall),
#                                 NA,
#                                 dplyr::if_else(CsvSnowfall == "T",
#                                                TRUE,
#                                                as.logical(SnowfallInches))))

# Save these as data.
devtools::use_data(airportData, overwrite = TRUE)
devtools::use_data(earlyDowntownData, overwrite = TRUE)
devtools::use_data(bothStations, overwrite = TRUE)
# devtools::use_data(mutatedBothStations, overwrite = TRUE)
