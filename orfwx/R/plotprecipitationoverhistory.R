plotPrecipitationOverHistory <- function(plotDate = searchDate()) {
  # Create a data frame with the weather for this day in history.
  dayInHistory <- subset(readWeatherData(), format(Date, "%m%d") == format(plotDate, "%m%d"))
  
  # Make a data frame with only the year and maximum temperature (orftmax)
  orfPrcp <- data.frame("year" = as.integer(format(dayInHistory$Date, "%Y")),
                        "precipitation" = as.numeric(as.character(dayInHistory$Precipitation)))
  
  # Manually add data for current year:
  todayPrcp <- data.frame("year" = format(plotDate, "%Y"),
                          "precipitation" = todaysPrecipitation)  # Temp data frame with current observations
  orfPrcp <- rbind(orfPrcp, todayPrcp) # Merge with historical observations
  
  # Remove years with text values for precipitation (missing and trace)
  orfPrcp <- na.omit(orfPrcp, orfPrcp$precipitation)
  
  # Remove years with no precipitation
  orfPrcp <- orfPrcp[orfPrcp$precipitation > 0, ]  # Comment out to include 0.00" values
  
  # Sort orfTMax by highTemperature
  orfPrcpSorted <- orfPrcp[order(orfPrcp$precipitation), ]
  
  plotWithManyBars(orfPrcpSorted$precipitation,
                   orfPrcpSorted,
                   paste("Precipitation on", format(currentDate, "%b %d"), "in Norfolk Weather History"),
                   paste("Precipitation on", format(currentDate, "%b %d"), "(in inches)"),
                   TRUE
  )
  
  minor.tick(nx = 1,
             ny = 5,
             tick.ratio = 0.5)
  # minor.tick(nx = 1,
  #            ny = 10,
  #            tick.ratio = 0.33)
  # minor.tick(nx = 1,
  #            ny = 2,
  #            tick.ratio = 0.67)
  mtext('Since 1874')
  #  mtext('Record warmest: __°F', line=-1)
  #  mtext('Record coldest: __°F', line=-2)
}
