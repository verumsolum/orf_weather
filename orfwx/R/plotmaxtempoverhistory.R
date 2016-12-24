#' Plot historical high tempertures
#' 
#' \code{plotMaxTempOverHistory} returns a barplot with the high temperatures
#' of one day each year.
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
#' temperatures for all days. The bar for the year provided by 
#' \code{daysWeather} (or, if \code{daysWeather} is not provided, the current 
#' year) is highlighted with a bar of a different color in the barplot.
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
#' @param tenTicks (optional) Writes tenth ticks (defaults to \code{TRUE}).
#' @return Returns a barplot.
#' @examples
#' plotMaxTempOverHistory(searchDate(11, 26))  # plot for November 26th
#' @export
plotMaxTempOverHistory <- function(wxUniverse = orfwx::bothStations,
                                   plotDate = searchDate(),
                                   daysWeather = NULL,
                                   twoTicks = TRUE,
                                   fiveTicks = FALSE,
                                   tenTicks = TRUE) {
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
  dayInHistory <- dayInHistory[order(dayInHistory$MaxTemperature), ]
  
  plotWithManyBars(dayInHistory$MaxTemperature,
                   dayInHistory,
                   paste("High Temperatures on", 
                         format(plotDate, "%b %d"), 
                         "in Norfolk Weather History"),
                   paste("High Temperature on", 
                         format(plotDate, "%b %d"), 
                         "(in \u00b0F)"),
                   highlightYear = daysWeatherYear
  )
  
  if (twoTicks) tickHalf()
  if (fiveTicks) tickFifth()
  if (tenTicks) tickTenth()
  graphics::mtext('Since 1874')
}
