#' Plot historical daily precipitation on a single date
#' 
#' \code{plotPrecipitationOverHistory} creates a barplot with the precipitation
#' of one day each year.
#' 
#' If \code{daysWeather} is passed (usually using 
#' \code{\link{singleDaysWeather}}), the function ensures that its weather is 
#' for the same date as that provided by \code{plotDate} (either passed to the 
#' function or the default value of the current system date). If they do not 
#' match, the function terminates with an error message.
#' 
#' The data from \code{daysWeather} is added to that provided by 
#' \code{wxUniverse} (by default, \code{\link{bothStations}}) and the weather
#' on the same date each year is compared.
#' 
#' A barplot is plotted by \code{\link{plotWithManyBars}} with the 
#' precipitation for the same date in all years, excluding those with no
#' precipitation or trace precipitation. The bar for the year provided by
#' \code{daysWeather} (or, if \code{daysWeather} is not provided, the current
#' year) is highlighted with a bar of a different color in the barplot.
#' 
#' @param wxUniverse (optional) The data frame containing the weather history
#'   to be searched (defaults to \code{bothStations}).
#' @param plotDate (optional) The date to be searched for, defaulting to the 
#'   current date.
#' @param daysWeather (optional) The weather for a date not yet included in
#'   the \code{wxUniverse} data frame, usually passed by the
#'   \code{singleDaysWeather} function.
#' @param twoTicks (optional) Writes half ticks (defaults to \code{TRUE}).
#' @param fiveTicks (optional) Writes fifth ticks (defaults to \code{FALSE}).
#' @param tenTicks (optional) Writes tenth ticks (defaults to \code{TRUE}).
#' @return Returns a barplot.
#' @examples
#' plotPrecipitationOverHistory(airportData, searchDate(11, 26))  # plot for November 26th
#' @export
plotPrecipitationOverHistory <- function(wxUniverse = orfwx::bothStations,
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
  
  # Add "extra" variables for sorting
  wxUniverse <- convertCsvToNumericAndLogical(wxUniverse)
  
  # Throw away extra information
  wxUniverse <- dplyr::select(wxUniverse,
                              Date,
                              CsvPrecipitation,
                              PrecipitationInches,
                              WithPrecipitation)
  
  # Create a data frame with the weather for this day in history.
  dayInHistory <- dplyr::filter(wxUniverse, 
                         format(Date, "%m%d") == format(plotDate, "%m%d"))
  
  # Remove years with missing data
  dayInHistory <- tidyr::drop_na(dayInHistory, PrecipitationInches)
  
  # Remove years with no precipitation
  dayInHistory <- dplyr::filter(dayInHistory, PrecipitationInches > 0)
  
  # Sort orfTMax by highTemperature
  dayInHistory <- dayInHistory[order(dayInHistory$PrecipitationInches), ]
  
  plotWithManyBars(dayInHistory$PrecipitationInches,
                   dayInHistory,
                   paste("Precipitation on", 
                         format(plotDate, "%b %d"), 
                         "in Norfolk Weather History"),
                   paste("Precipitation on", 
                         format(plotDate, "%b %d"), 
                         "(in inches)"),
                   TRUE,
                   highlightYear = daysWeatherYear
  )
  
  if (twoTicks) tickHalf()
  if (fiveTicks) tickFifth()
  if (tenTicks) tickTenth()
  graphics::mtext('Years \u2265 0.01" since 1874')
}
