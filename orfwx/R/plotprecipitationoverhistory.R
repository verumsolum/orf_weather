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
#' @param daysWeather (optional) The weather for a date not yet included in
#'   the \code{mutatedBothStations} dataset, usually passed by the
#'   \code{singleDaysWeather} function.
#' @return Returns a barplot.
#' @examples
#' plotPrecipitationOverHistory(searchDate(11, 26))  # plot for November 26th
#' @export
plotPrecipitationOverHistory <- function(plotDate = searchDate()
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
  orfPrcp <- data.frame("year" = as.integer(format(dayInHistory$Date, "%Y")),
                        "precipitation" = 
                          as.numeric(as.character(dayInHistory$Precipitation)))
  
  # If daysWeather is not NULL, add data for current year:
  if (!is.null(daysWeather)) {
    daysWeatherYear <- format(daysWeather$Date, "%Y")
    # todayPrcp is temp data frame with current observations
    todayPrcp <- data.frame("year" = format(plotDate, "%Y"),
                            "precipitation" = todaysPrecipitation)
    orfPrcp <- rbind(orfPrcp, todayPrcp) # Merge with historical observations
  } else {
    daysWeatherYear <- format(Sys.Date(), "%Y")
  }
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
                   TRUE,
                   highlightYear = daysWeatherYear
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
