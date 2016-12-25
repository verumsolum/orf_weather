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
#' @param wxUniverse (optional) The data frame containing the weather history
#'   to be searched. Defaults to \code{bothStations}.
#' @param plotDate (optional) The date to be searched for, defaulting to the 
#'   current date.
#' @param daysWeather (optional) The weather for a date not yet included in
#'   the \code{mutatedBothStations} dataset, usually passed by the
#'   \code{singleDaysWeather} function.
#' @param twoTicks (optional) Writes half ticks (defaults to \code{TRUE}).
#' @param fiveTicks (optional) Writes fifth ticks (defaults to \code{FALSE}).
#' @param tenTicks (optional) Writes tenth ticks (defaults to \code{FALSE}).
#' @return Returns a barplot.
#' @examples
#' plotWarmestMaxTempOverHistory(searchDate(11, 26))  # plot for November 26th
#' @export
plotWarmestMaxTempOverHistory <- function(wxUniverse = orfwx::bothStations,
                                          plotDate = searchDate(),
                                          daysWeather = NULL,
                                          twoTicks = TRUE,
                                          fiveTicks = FALSE,
                                          tenTicks = FALSE) {
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
      plotDate <- as.Date(daysWeather$Date)
      daysWeatherYear <- format(daysWeather$Date, "%Y")
      wxUniverse <- combineDataFrames(wxUniverse, daysWeather)
    }
  } else {
    # If daysWeather is NULL
    daysWeatherYear <- format(Sys.Date(), "%Y")
  }
  
  # Throw away extra information
  wxUniverse <- dplyr::select(wxUniverse, Date, MaxTemperature)
  
  # Create a data frame with the weather for this day in history.
  dayInHistory <- dplyr::filter(wxUniverse, 
                         format(Date, "%m%d") == format(plotDate, "%m%d"))
  
  # Sort orfTMax by highTemperature
  dayInHistory <- dplyr::arrange(dayInHistory, dplyr::desc(MaxTemperature))

  # If daysWeather has not been passed,
  # or if daysWeather$highTemperature is in the warmest 10,
  # filter orfTMaxSorted to online include those 10 (and ties)
  if (is.null(daysWeather)) {
    dayInHistory <- dplyr::top_n(dayInHistory, 10, MaxTemperature)
  } else if (dayInHistory$MaxTemperature[10] <= daysWeather$MaxTemperature) {
    dayInHistory <- dplyr::top_n(dayInHistory, 10, MaxTemperature)
  } else {
    # Otherwise, include all days colder than (or equal to)
    # daysWeather$MaxTemperature
    dayInHistory <- dplyr::filter(dayInHistory,
                                  MaxTemperature >= daysWeather$MaxTemperature)
  }
  
  dayInHistory <- dplyr::arrange(dayInHistory, MaxTemperature, Date)
  
  plotWithManyBars(dayInHistory$MaxTemperature,
                   dayInHistory,
                   paste("Warmest High Temperatures on", 
                         format(plotDate, "%b %d"), 
                         "in Norfolk Weather History"),
                   paste("High temperature on", 
                         format(plotDate, "%b %d"), 
                         "(in \u00b0F)"),
                   showAllLabels = TRUE,
                   highlightYear = daysWeatherYear
  )
  
  if (twoTicks) tickHalf()
  if (fiveTicks) tickFifth()
  if (tenTicks) tickTenth()
  graphics::mtext('Since 1874')
}
