#' Plot warmest historical high tempertures on a single date
#' 
#' \code{plotWarmestMaxTempOverHistory} returns a barplot with the warmest 
#' high temperatures of one day of the year.
#' 
#' If \code{daysWeather} is passed (usually using 
#' \code{\link{singleDaysWeather}}), the function ensures that its weather is 
#' for the same date as that provided by \code{plotDate} (either passed to the 
#' function or the default value of the current system date). If they do not 
#' match, the function terminates with an error message.
#' 
#' The data from \code{daysWeather} is added to that provided by 
#' \code{\link{mutatedBothStations}} and the weather on the same date each year
#' is compared.
#' 
#' A barplot is plotted by \code{\link{plotWithManyBars}} with the high 
#' temperatures for all days with a high temperature greater than or equal to 
#' that provided by \code{daysWeather}. (In all cases, the ten warmest years 
#' shown, along with any ties, with additional years added until the year 
#' are provided by \code{daysWeather} is shown, and also all years tied with 
#' the same temperature.) The bar for the year provided by \code{daysWeather} 
#' (or, if \code{daysWeather} is not provided, the current year) is 
#' highlighted with a bar of a different color in the barplot.
#' 
#' @param plotDate (optional) The date to be searched for, defaulting to the 
#'   current date.
#' @param daysWeather (optional) The weather for a date not yet included in
#'   the \code{mutatedBothStations} dataset, usually passed by the
#'   \code{singleDaysWeather} function.
#' @return Returns a barplot.
#' @examples
#' plotWarmestMaxTempOverHistory(searchDate(11, 26))  # plot for November 26th
#' @export
plotWarmestMaxTempOverHistory <- function(plotDate = searchDate(),
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
  orfTMaxSorted <- arrange(orfTMax, desc(highTemperature))
  if(orfTMaxSorted$highTemperature[10] <= daysWeather$MaxTemperature) {
    orfTMaxSorted <- filter(orfTMaxSorted, 
                            highTemperature >= 
                              orfTMaxSorted$highTemperature[10])
  } else {
    orfTMaxSorted <- filter(orfTMaxSorted, 
                            highTemperature >= daysWeather$MaxTemperature)
  }
  # browser()
  orfTMaxSorted <- arrange(orfTMaxSorted, highTemperature, as.integer(year))
  
  plotWithManyBars(orfTMaxSorted$highTemperature,
                   orfTMaxSorted,
                   paste("Warmest High Temperatures on", 
                         format(plotDate, "%b %d"), 
                         "in Norfolk Weather History"),
                   paste("High temperature on", 
                         format(plotDate, "%b %d"), 
                         "(in °F)"),
                   showAllLabels = TRUE,
                   highlightYear = daysWeatherYear
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
}
