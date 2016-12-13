# NOTE: Run this file from the data-raw directory to create data objects.

library(utils)
library(dplyr, warn.conflicts = FALSE)
library(devtools)

# Read Norfolk airport weather data from CSV
airport <- read.csv(
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
overlappingDowntown <- read.csv(
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

# Remove duplicate dates (only use downtown before 1946-01-01)
downtown <-
  overlappingDowntown[which(overlappingDowntown$Date < as.Date("1946-01-01")),]
bothStations <- rbind(airport, downtown)
bothStations <- arrange(bothStations, Date)
mutatedBothStations <- mutate(
  bothStations,
  Year = as.integer(strftime(Date, 
                             format = "%Y")),
  Month = as.integer(strftime(Date, 
                              format = "%m")),
  DayOfMonth = as.integer(strftime(Date, 
                                   format = "%d")),
  DayOfYear = as.integer(strftime(Date, 
                                  format = "%j")),
  MaxTemperature = as.integer(MaxTemperature),
  MinTemperature = as.integer(MinTemperature)
)
mutatedBothStations <- tbl_df(mutatedBothStations)
mutatedBothStations <- mutate(
  mutatedBothStations,
  leapYearAwareDayOfYear = ifelse(Month > 3 & !is.leapYear(Year), 
                                  DayOfYear + 1, 
                                  DayOfYear),
  temperatureSpread = as.integer(MaxTemperature - MinTemperature)
)

# Rename Precipitation -> CsvPrecipitation
mutatedBothStations <- mutate(mutatedBothStations, 
                              CsvPrecipitation = Precipitation) %>%
  select(-Precipitation)

# Create two new variables from CsvPrecipitation
mutatedBothStations <- mutate(mutatedBothStations,
                              PrecipitationInches =
                                if_else(is.na(CsvPrecipitation),
                                        NA_real_,
                                        if_else(CsvPrecipitation == "T",
                                                0,
                                                as.numeric(as.character(
                                                  CsvPrecipitation)))),
                              WithPrecipitation =
                                if_else(is.na(CsvPrecipitation),
                                        NA,
                                        if_else(CsvPrecipitation == "T",
                                                TRUE,
                                                as.logical(
                                                  PrecipitationInches))))

# Rename Snowfall -> CsvSnowfall
mutatedBothStations <- mutate(mutatedBothStations, CsvSnowfall = Snowfall) %>%
  select(-Snowfall)

# Create two new variables from CsvSnowfall
mutatedBothStations <- mutate(mutatedBothStations,
                              SnowfallInches =
                                if_else(is.na(CsvSnowfall),
                                        NA_real_,
                                        if_else(CsvSnowfall == "T",
                                                0,
                                                as.numeric(as.character(
                                                  CsvSnowfall)))),
                              WithSnowfall =
                                if_else(is.na(CsvSnowfall),
                                        NA,
                                        if_else(CsvSnowfall == "T",
                                                TRUE,
                                                as.logical(SnowfallInches))))

# Save this as data.
devtools::use_data(mutatedBothStations, overwrite = TRUE)
