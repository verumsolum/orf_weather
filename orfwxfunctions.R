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

plotWarmestMaxTempOverHistory <- function(plotDate = searchDate()) {
  # Create a data frame with the weather for this day in history.
  dayInHistory <- subset(readWeatherData(), format(Date, "%m%d") == format(plotDate, "%m%d"))
  
  # Make a data frame with only the year and maximum temperature (orftmax)
  orfTMax <- data.frame("year" = as.integer(format(dayInHistory$Date, "%Y")),
                        "highTemperature" = dayInHistory$MaxTemperature)
  
  # Manually add data for current year:
  todayTMax <- data.frame("year" = format(plotDate, "%Y"),
                          "highTemperature" = todaysHigh)  # Temp data frame with current observations
  orfTMax <- rbind(orfTMax, todayTMax) # Merge with historical observations
  
  # Sort orfTMax by highTemperature
  orfTMaxSorted <- arrange(orfTMax, desc(highTemperature))
  if(orfTMaxSorted$highTemperature[10] <= todaysHigh) {
    orfTMaxSorted <- filter(orfTMaxSorted, highTemperature >= orfTMaxSorted$highTemperature[10])
  } else {
    orfTMaxSorted <- filter(orfTMaxSorted, highTemperature >= todaysHigh)
  }
  # browser()
  orfTMaxSorted <- arrange(orfTMaxSorted, highTemperature, as.integer(year))
  
  plotWithManyBars(orfTMaxSorted$highTemperature,
                   orfTMaxSorted,
                   paste("Warmest High Temperatures on", format(plotDate, "%b %d"), "in Norfolk Weather History"),
                   paste("High temperature on", format(plotDate, "%b %d"), "(in °F)"),
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

plotCoolestMaxTempOverHistory <- function(plotDate = searchDate()) {
  # Create a data frame with the weather for this day in history.
  dayInHistory <- subset(readWeatherData(), format(Date, "%m%d") == format(plotDate, "%m%d"))
  
  # Make a data frame with only the year and maximum temperature (orftmax)
  orfTMax <- data.frame("year" = as.integer(format(dayInHistory$Date, "%Y")),
                        "highTemperature" = dayInHistory$MaxTemperature)
  
  # Manually add data for current year:
  todayTMax <- data.frame("year" = format(plotDate, "%Y"),
                          "highTemperature" = todaysHigh)  # Temp data frame with current observations
  orfTMax <- rbind(orfTMax, todayTMax) # Merge with historical observations
  
  # Sort orfTMax by highTemperature
  orfTMaxSorted <- arrange(orfTMax, highTemperature)
  if(orfTMaxSorted$highTemperature[10] >= todaysHigh) {
    orfTMaxSorted <- filter(orfTMaxSorted, highTemperature <= orfTMaxSorted$highTemperature[10])
  } else {
    orfTMaxSorted <- filter(orfTMaxSorted, highTemperature <= todaysHigh)
  }
  # browser()
  orfTMaxSorted <- arrange(orfTMaxSorted, highTemperature)
  
  plotWithManyBars(orfTMaxSorted$highTemperature,
                   orfTMaxSorted,
                   paste("Coolest High Temperatures on", format(plotDate, "%b %d"), "in Norfolk Weather History"),
                   paste("High temperature on", format(plotDate, "%b %d"), "(in °F)"),
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

plotCoolestMinTempOverHistory <- function(plotDate = searchDate()) {
  # Create a data frame with the weather for this day in history.
  dayInHistory <- subset(readWeatherData(), format(Date, "%m%d") == format(plotDate, "%m%d"))
  
  # Make a data frame with only the year and minimum temperature (orftmin)
  orfTMin <- data.frame("year" = as.integer(format(dayInHistory$Date, "%Y")),
                        "lowTemperature" = dayInHistory$MinTemperature)
  
  # Manually add data for current year:
  todayTMin <- data.frame("year" = format(plotDate, "%Y"),
                          "lowTemperature" = todaysLow)  # Temp data frame with current observations
  orfTMin <- rbind(orfTMin, todayTMin) # Merge with historical observations
  
  # Sort orfTMin by lowTemperature
  orfTMinSorted <- arrange(orfTMin, lowTemperature)
  if(orfTMinSorted$lowTemperature[10] >= todaysLow) {
    orfTMinSorted <- filter(orfTMinSorted, lowTemperature <= orfTMinSorted$lowTemperature[10])
  } else {
    orfTMinSorted <- filter(orfTMinSorted, lowTemperature <= todaysLow)
  }
  # browser()
  orfTMinSorted <- arrange(orfTMinSorted, lowTemperature)
  
  plotWithManyBars(orfTMinSorted$lowTemperature,
                   orfTMinSorted,
                   paste("Coolest Low Temperatures on", format(plotDate, "%b %d"), "in Norfolk Weather History"),
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
