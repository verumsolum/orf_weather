# NOTE: Run this file from the data-raw directory to create data objects.

library(utils)
library(dplyr, warn.conflicts = FALSE)
library(devtools)
library(readr)

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
airportNormals <- readr::read_csv("ApNormals1981-2010.csv")

# Rename Precipitation and Snowfall variables, so we don't have to do it later
airportData <- dplyr::rename(airportData,
                             CsvPrecipitation = Precipitation,
                             CsvSnowfall = Snowfall)
downtownData <- dplyr::rename(downtownData,
                              CsvPrecipitation = Precipitation,
                              CsvSnowfall = Snowfall)

# Rename normals variables to match our other data
airportNormals <- dplyr::rename(airportNormals,
                                YTDPrecip = `pcpn|sum`,
                                MaxTemperature = maxt,
                                MinTemperature = mint,
                                AvgTemperature = avgt) %>%
  dplyr::mutate(Month = as.Date(date, "%m-%d") %>% 
                  format("%m") %>% 
                  as.integer(),
                DayOfMonth = as.Date(date, "%m-%d") %>%
                  format("%d") %>%
                  as.integer()) %>%
  dplyr::select(Month, DayOfMonth, dplyr::everything(), -date)

# Determine a monthly baseline (for use in calculating MTDPrecip)
monthlyBaseline <- airportNormals %>%
  dplyr::group_by(Month) %>%
  dplyr::summarise(maxYTDPrecip = max(YTDPrecip)) %>%
  dplyr::mutate(Month = Month + 1) %>% 
  dplyr::rename(prevMonthEndYTDPrecip = maxYTDPrecip)

# Get rid of month 13 and add a month 1 with 0 and re-sort
monthlyBaseline[12, ] <- list(1,0)
monthlyBaseline <- dplyr::arrange(monthlyBaseline, Month)

# Join monthlyBaseline to airportNormals, then use to calculate MTDPrecip
airportNormals <- dplyr::left_join(airportNormals, 
                                   monthlyBaseline, 
                                   by = "Month") %>% 
  dplyr::mutate(MTDPrecip = YTDPrecip - prevMonthEndYTDPrecip) %>%
  dplyr::select(Month, 
                DayOfMonth, 
                MTDPrecip, 
                dplyr::everything(), 
                -prevMonthEndYTDPrecip)

# Remove duplicate dates (only use downtown before 1946-01-01)
earlyDowntownData <-
  downtownData[which(downtownData$Date < as.Date("1946-01-01")),]
bothStations <- rbind(airportData, earlyDowntownData)
bothStations <- dplyr::arrange(bothStations, Date)

# Convert these variables to tibbles
airportData <- dplyr::tbl_df(airportData)
earlyDowntownData <- dplyr::tbl_df(earlyDowntownData)
bothStations <- dplyr::tbl_df(bothStations)

# Save these as data.
devtools::use_data(airportData, overwrite = TRUE)
devtools::use_data(earlyDowntownData, overwrite = TRUE)
devtools::use_data(bothStations, overwrite = TRUE)
devtools::use_data(airportNormals, overwrite = TRUE)
