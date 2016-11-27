plotWarmestMinTempOverHistory <- function(plotDate = searchDate()) {
  # Create a data frame with the weather for this day in history.
  dayInHistory <- subset(readWeatherData(), format(Date, "%m%d") == format(plotDate, "%m%d"))
  
  # Make a data frame with only the year and minimum temperature (orftmin)
  orfTMin <- data.frame("year" = as.integer(format(dayInHistory$Date, "%Y")),
                        "lowTemperature" = dayInHistory$MinTemperature)
  
  # Manually add data for current year:
  todayTMin <- data.frame("year" = as.integer(format(plotDate, "%Y")),
                          "lowTemperature" = todaysLow)  # Temp data frame with current observations
  orfTMin <- rbind(orfTMin, todayTMin) # Merge with historical observations
  
  # Sort orfTMin by lowTemperature
  orfTMinSorted <- arrange(orfTMin, desc(lowTemperature))
  if(orfTMinSorted$lowTemperature[10] <= todaysLow) {
    orfTMinSorted <- filter(orfTMinSorted, lowTemperature >= orfTMinSorted$lowTemperature[10])
  } else {
    orfTMinSorted <- filter(orfTMinSorted, lowTemperature >= todaysLow)
  }
  # browser()
  orfTMinSorted <- arrange(orfTMinSorted, lowTemperature, as.integer(year))
  
  plotWithManyBars(orfTMinSorted$lowTemperature,
                   orfTMinSorted,
                   paste("Warmest Low Temperatures on", format(plotDate, "%b %d"), "in Norfolk Weather History"),
                   paste("Low temperature on", format(plotDate, "%b %d"), "(in °F)"),
                   showAllLabels = TRUE
  )
  
  # minor.tick(nx = 1,
  #            ny = 5,
  #            tick.ratio = 0.5)
  # minor.tick(nx = 1,
  #            ny = 10,
  #            tick.ratio = 0.33)
  minor.tick(nx = 1,
             ny = 2,
             tick.ratio = 0.67)
  mtext('Since 1874')
  #  mtext('Record warmest: __°F', line=-1)
  #  mtext('Record coldest: __°F', line=-2)
}
