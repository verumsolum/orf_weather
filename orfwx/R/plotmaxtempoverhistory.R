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
