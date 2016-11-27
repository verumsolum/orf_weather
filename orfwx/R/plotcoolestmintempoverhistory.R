#' Plot coolest historical low tempertures on a single date
#' 
#' \code{plotCoolestMinTempOverHistory} returns a barplot with the coolest 
#' loq temperatures of one day of the year.
#' 
#' This code makes my head hurt, because it was some of the earliest R code I
#' wrote, when I was mostly in make-it-work mode, with huge gaps in my
#' understanding of R (and of barplot particularly)
#' 
#' @param plotDate (optional) The date to be searched for, defaulting to the 
#'   current date.
#' @return Returns a barplot.
#' @examples
#' plotCoolestMaxTempOverHistory(searchDate(11, 26))  # plot for November 26th
#' @export
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
