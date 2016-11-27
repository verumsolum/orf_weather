#' Plot coolest historical high tempertures on a single date
#' 
#' \code{plotCoolestMaxTempOverHistory} returns a barplot with the coolest 
#' high temperatures of one day of the year.
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
plotCoolestMaxTempOverHistory <- function(plotDate = searchDate()) {
  # Create a data frame with the weather for this day in history.
  dayInHistory <- subset(mutatedBothStations, 
                         format(Date, "%m%d") == format(plotDate, "%m%d"))
  
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
