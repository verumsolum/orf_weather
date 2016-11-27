#' Plot historical high tempertures
#' 
#' \code{plotMaxTempOverHistory} returns a barplot with the high temperatures
#' of one day each year.
#' 
#' This code makes my head hurt, because it was some of the earliest R code I
#' wrote, when I was mostly in make-it-work mode, with huge gaps in my
#' understanding of R (and of barplot particularly)
#' 
#' @param plotDate (optional) The date to be searched for, defaulting to the 
#'   current date.
#' @return Returns a barplot.
#' @examples
#' plotMaxTempOverHistory(searchDate(11, 26))  # plot for November 26th
#' @export
plotMaxTempOverHistory <- function(plotDate = searchDate()) {
  # Create a data frame with the weather for this day in history.
  dayInHistory <- subset(mutatedBothStations, 
                         format(Date, "%m%d") == format(plotDate, "%m%d"))
  
  # Make a data frame with only the year and maximum temperature (orftmax)
  orfTMax <- data.frame("year" = as.integer(format(dayInHistory$Date, "%Y")),
                        "highTemperature" = dayInHistory$MaxTemperature)
  
  # Manually add data for current year:
  # todayTMax is temp data frame with current observations
  todayTMax <- data.frame("year" = format(plotDate, "%Y"),
                          "highTemperature" = todaysHigh)
  orfTMax <- rbind(orfTMax, todayTMax) # Merge with historical observations
  
  # Sort orfTMax by highTemperature
  orfTMaxSorted <- orfTMax[order(orfTMax$highTemperature), ]
  
  plotWithManyBars(orfTMaxSorted$highTemperature,
                   orfTMaxSorted,
                   paste("High Temperatures on", 
                         format(plotDate, "%b %d"), 
                         "in Norfolk Weather History"),
                   paste("High Temperature on", 
                         format(plotDate, "%b %d"), 
                         "(in °F)")
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
}
