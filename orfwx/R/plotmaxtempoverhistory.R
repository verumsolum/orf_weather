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
#' @param daysWeather (optional) The weather for a date not yet included in
#'   the \code{mutatedBothStations} dataset, usually passed by the
#'   \code{singleDaysWeather} function.
#' @return Returns a barplot.
#' @examples
#' plotMaxTempOverHistory(searchDate(11, 26))  # plot for November 26th
#' @export
plotMaxTempOverHistory <- function(plotDate = searchDate(),
                                   daysWeather = NULL) {
  # Ensure that daysWeather is correct
  if (!is.null(daysWeather)) {
    # If daysWeather is set, 
    # ensure that the date value from daysWeather matches
    if (format(daysWeather$Date, "%m%d") != format(plotDate, "%m%d")) {
      # If days don't match…
      stop("plotDate and daysWeather$Date do not match")
    } else {
      # If they match, ensure that plotDate uses the same year as
      # daysWeather$Date
      plotDate <- as.Date(paste0(format(daysWeather$Date, "%Y"),
                                 "-",
                                 format(plotDate, "%m-%d")))
    }
  }
  
  # Create a data frame with the weather for this day in history.
  dayInHistory <- subset(mutatedBothStations, 
                         format(Date, "%m%d") == format(plotDate, "%m%d"))
  
  # Make a data frame with only the year and maximum temperature (orftmax)
  orfTMax <- data.frame("year" = as.integer(format(dayInHistory$Date, "%Y")),
                        "highTemperature" = dayInHistory$MaxTemperature)
  
  # If daysWeather is not NULL, add data for current year:
  if (!is.null(daysWeather)) {
    daysWeatherYear <- format(daysWeather$Date, "%Y")
    # todayTMax is temp data frame with current observations
    todayTMax <- data.frame("year" = format(plotDate, "%Y"),
                            "highTemperature" = daysWeather$MaxTemperature)
    orfTMax <- rbind(orfTMax, todayTMax) # Merge with historical observations
  } else {
    daysWeatherYear <- format(Sys.Date(), "%Y")
  }
  # Sort orfTMax by highTemperature
  orfTMaxSorted <- orfTMax[order(orfTMax$highTemperature), ]
  
  plotWithManyBars(orfTMaxSorted$highTemperature,
                   orfTMaxSorted,
                   paste("High Temperatures on", 
                         format(plotDate, "%b %d"), 
                         "in Norfolk Weather History"),
                   paste("High Temperature on", 
                         format(plotDate, "%b %d"), 
                         "(in °F)"),
                   highlightYear = daysWeatherYear
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
