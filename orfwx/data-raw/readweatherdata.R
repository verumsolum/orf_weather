readWeatherData <- function() {
  # Leave this function in orfwxfunctions.R until package complete.
  # Read Norfolk airport weather data from CSV
  airport <- read.csv("NorfolkIntlAp.csv",
                      colClasses = c("Date", "integer", "integer", "numeric", "factor", "factor"),
                      na.strings = c("M", NULL))
  overlappingDowntown <- read.csv("NorfolkWbCity.csv",
                                  colClasses = c("Date", "integer", "integer", "numeric", "factor", "factor"),
                                  na.strings = c("M", NULL))
  # Remove duplicate dates (only use downtown before 1946-01-01)
  downtown <- overlappingDowntown[which(overlappingDowntown$Date < as.Date("1946-01-01")), ]
  bothStations <- rbind(airport, downtown)
  bothStations <- arrange(bothStations, Date)
  mutatedBothStations <- mutate(bothStations,
                                Year = as.integer(strftime(Date, format="%Y")),
                                Month = as.integer(strftime(Date, format="%m")),
                                DayOfMonth = as.integer(strftime(Date, format="%d")),
                                DayOfYear = as.integer(strftime(Date, format="%j")),
                                MaxTemperature = as.integer(MaxTemperature),
                                MinTemperature = as.integer(MinTemperature))
  mutatedBothStations <- tbl_df(mutatedBothStations)
  mutatedBothStations <- mutate(mutatedBothStations,
                                leapYearAwareDayOfYear = ifelse(Month > 3 & !is.leapYear(Year), DayOfYear + 1, DayOfYear),
                                temperatureSpread = as.integer(MaxTemperature - MinTemperature))
}
