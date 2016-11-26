plotMinTempOverHistory <- function(plotDate = searchDate()) {
  # Create a data frame with the weather for this day in history.
  dayInHistory <- subset(readWeatherData(), format(Date, "%m%d") == format(plotDate, "%m%d"))
  
  # Make a data frame with only the year and maximum temperature (orftmax)
  orfTMin <- data.frame("year" = as.integer(format(dayInHistory$Date, "%Y")),
                        "lowTemperature" = dayInHistory$MinTemperature)
  
  # Manually add data for current year:
  todayTMin <- data.frame("year" = format(plotDate, "%Y"),
                          "lowTemperature" = todaysLow)  # Temp data frame with current observations
  orfTMin <- rbind(orfTMin, todayTMin) # Merge with historical observations
  
  # Sort orfTMax by highTemperature
  orfTMinSorted <- orfTMin[order(orfTMin$lowTemperature), ]
  
  plotWithManyBars(orfTMinSorted$lowTemperature,
                   orfTMinSorted,
                   paste("Low Temperatures on", format(plotDate, "%b %d"), "in Norfolk Weather History"),
                   paste("Low Temperature on", format(plotDate, "%b %d"), "(in °F)")
  )
  
  # minor.tick(nx = 1,
  #            ny = 5,
  #            tick.ratio = 0.5)
  minor.tick(nx = 1,
             ny = 10,
             tick.ratio = 0.33)
  minor.tick(nx = 1,
             ny = 2,
             tick.ratio = 0.67)
  mtext('Since 1874')
  #  mtext('Record warmest: __°F', line=-1)
  #  mtext('Record coldest: __°F', line=-2)
}
