is.leapYear=function(year){
  #http://en.wikipedia.org/wiki/Leap_year
  return(((year %% 4 == 0) & (year %% 100 != 0)) | (year %% 400 == 0))
}

readWeatherData <- function() {
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

padSingleDigitInteger <- function(theInteger) {
  if(as.numeric(theInteger) >= 10 ) return(abs(as.integer(theInteger)))  # What is good style for if in R
  paste0("0", as.character(abs(as.integer(theInteger))))
}

searchDate <- function(searchMonth = format(Sys.Date(), "%m"),
                       searchDay = format(Sys.Date(), "%d")) {
  searchDateString <- paste0(padSingleDigitInteger(searchMonth), 
                             padSingleDigitInteger(searchDay))
  as.Date(searchDateString, "%m%d")
}

plotWithManyBars <- function(sortedData,
                             sortedDataFrame,
                             titlePlotWmb,
                             yAxisLabelPlotWmb,
                             plottingPrecip = FALSE,
                             showAllLabels = FALSE) {
  # Convenience variables:
  minSortedData <- sortedData[1]
  maxSortedData <- sortedData[length(sortedData)]
  
  # Determin ylim
  yAxisLimitsCalculated <- ifelse(c(plottingPrecip == FALSE, plottingPrecip == FALSE),
                                  c(floor((minSortedData - 1) / 5) * 5,
                                    ceiling((maxSortedData) / 5) * 5),
                                  c(0,ceiling((maxSortedData) / 0.5) * 0.5))

  # Graph sortedData
  barplot(as.numeric(sortedData),
          # cex.names = 0.6,  # Smaller text for year label
          cex.names = ifelse(showAllLabels == TRUE, 0.9, 0.6),
          # las = 2, # rotate labels perpendicular to axis
          las = ifelse(showAllLabels == TRUE, 0, 2),
          main = titlePlotWmb,  # Title
          ylab = yAxisLabelPlotWmb,  # Label for y axis
          ylim = yAxisLimitsCalculated,
#           ylim = c(floor((minSortedData - 1) / 5) * 5,
#                    ceiling((maxSortedData + 1) /5) * 5),  # Limits of y axis  # TODO: Automatic limits
          xpd = FALSE,  # Do not allow the bars to go outside the plot region (i.e., above/below ylim)
          # names.arg = ifelse(sortedDataFrame$year == 2016 |
          #                      sortedData == minSortedData |
          #                      sortedData == maxSortedData, 
          #                    paste(sortedDataFrame$year, "-", paste0(sortedData, "°")),
          #                    ""),  # Source of labels for x axis
          names.arg = if(showAllLabels == FALSE & plottingPrecip == FALSE) { 
            ifelse(sortedDataFrame$year == 2016 |
                     sortedData == minSortedData |
                     sortedData == maxSortedData, 
                   paste(sortedDataFrame$year, "-", paste0(sortedData, "°")),
                   "")  # Source of labels for x axis
          } else {
            # paste(sortedDataFrame$year, "-", paste0(sortedData, "°"))
            if(plottingPrecip == FALSE) {
              paste(paste0(sortedData, "°"), "\n", sortedDataFrame$year)
              } else {
                paste(sortedDataFrame$year, "-", paste0(format(sortedData, nsmall = 2), '"'))
              }
          },
          col = ifelse(sortedDataFrame$year == 2016, "mediumpurple", "steelblue1"),
          border = "white")
  grid(nx = NA,
       ny = NULL,
       lty = "dotted")
}

plotMaxTempOverHistory <- function(plotDate = searchDate()) {
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
  orfTMaxSorted <- orfTMax[order(orfTMax$highTemperature), ]
  
  plotWithManyBars(orfTMaxSorted$highTemperature,
                   orfTMaxSorted,
                   paste("High Temperatures on", format(plotDate, "%b %d"), "in Norfolk Weather History"),
                   paste("High Temperature on", format(plotDate, "%b %d"), "(in °F)")
                   )
  
  ### START plotWithManyBars
  
  # # Convenience variables:
  # recordLowTMax <- newOrfTMaxSorted$highTemperature[1]
  # recordHighTMax <- newOrfTMaxSorted$highTemperature[length(newOrfTMaxSorted$highTemperature)]
  # 
  # # Graph orfTMaxSorted
  # barplot(as.numeric(newOrfTMaxSorted$highTemperature),
  #         cex.names = 0.6,  # Smaller text for year label
  #         las = 2, # rotate labels perpendicular to axis
  #         main = paste("High Temperatures on", format(plotDate, "%b %d"), "in Norfolk Weather History"),  # Title - CHANGE if updated to do other than currentDate
  #         # xlab = "Year",  # Label for x axis
  #         ylab = paste("High Temperature on", format(plotDate, "%b %d"), "(in °F)"),  # Label for y axis
  #         ylim = c(floor((recordLowTMax - 1) / 5) * 5,
  #                  ceiling((recordHighTMax + 1) /5) * 5),  # Limits of y axis  # TODO: Automatic limits
  #         xpd = FALSE,  # Do not allow the bars to go outside the plot region (i.e., above/below ylim)
  #         names.arg = ifelse(newOrfTMaxSorted$year == 2016 |
  #                              newOrfTMaxSorted$highTemperature == recordLowTMax |
  #                              newOrfTMaxSorted$highTemperature == recordHighTMax, 
  #                            paste(newOrfTMaxSorted$year, "-", paste0(newOrfTMaxSorted$highTemperature, "°")),
  #                            ""),  # Source of labels for x axis
  #         col = ifelse(newOrfTMaxSorted$year == 2016, "mediumpurple", "steelblue1"),
  #         border = "white")
  # grid(nx = NA,
  #      ny = NULL,
  #      lty = "dotted")
  
  ### END plotWithManyBars
  
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
