#' Plot historical daily precipitation
#' 
#' \code{plotPrecipitationOverHistory} returns a barplot with the precipitation
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
#' plotPrecipitationOverHistory(searchDate(11, 26))  # plot for November 26th
#' @export
plotPrecipitationOverHistory <- function(plotDate = searchDate()) {
  # Create a data frame with the weather for this day in history.
  dayInHistory <- subset(mutatedBothStations, 
                         format(Date, "%m%d") == format(plotDate, "%m%d"))
  
  # Make a data frame with only the year and maximum temperature (orftmax)
  orfPrcp <- data.frame("year" = as.integer(format(dayInHistory$Date, "%Y")),
                        "precipitation" = 
                          as.numeric(as.character(dayInHistory$Precipitation)))
  
  # Manually add data for current year:
  # todayPrcp is temp data frame with current observations
  todayPrcp <- data.frame("year" = format(plotDate, "%Y"),
                          "precipitation" = todaysPrecipitation)
  orfPrcp <- rbind(orfPrcp, todayPrcp) # Merge with historical observations
  
  # Remove years with text values for precipitation (missing and trace)
  orfPrcp <- na.omit(orfPrcp, orfPrcp$precipitation)
  
  # Remove years with no precipitation
  orfPrcp <- orfPrcp[orfPrcp$precipitation > 0, ]
  
  # Sort orfTMax by highTemperature
  orfPrcpSorted <- orfPrcp[order(orfPrcp$precipitation), ]
  
  plotWithManyBars(orfPrcpSorted$precipitation,
                   orfPrcpSorted,
                   paste("Precipitation on", 
                         format(currentDate, "%b %d"), 
                         "in Norfolk Weather History"),
                   paste("Precipitation on", 
                         format(currentDate, "%b %d"), 
                         "(in inches)"),
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
}
