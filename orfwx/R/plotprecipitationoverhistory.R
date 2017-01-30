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
#' \code{wxUniverse} (by default, \code{\link{allData}}) and the weather
#' on the same date each year is compared.
#' 
#' A barplot is plotted by \code{\link{plotWithManyBars}} with the 
#' precipitation for the same date in all years, excluding those with no
#' precipitation or trace precipitation. The bar for the year provided by
#' \code{daysWeather} (or, if \code{daysWeather} is not provided, the current
#' year as of yesterday) is highlighted with a bar of a different color in the 
#' barplot.
#' 
#' @param wxUniverse (optional) The data frame containing the weather history
#'   to be searched (defaults to \code{allData}).
#' @param plotDate (optional) The date to be searched for, defaulting to
#'   yesterday's date.
#' @param daysWeather (optional) The weather for a date not yet included in
#'   the \code{wxUniverse} data frame, usually passed by the
#'   \code{singleDaysWeather} function.
#' @param twoTicks (optional) Writes half ticks (defaults to \code{TRUE}).
#' @param fiveTicks (optional) Writes fifth ticks (defaults to \code{FALSE}).
#' @param tenTicks (optional) Writes tenth ticks (defaults to \code{TRUE}).
#' @param saveToFile (optional) Writes plot to a PNG file (defaults to 
#'   \code{FALSE}).
#' @return Returns a barplot.
#' @examples
#' plotPrecipitationOverHistory(airportData, searchDate(11, 26))  
#' # Returns plot for November 26th
#' @export
plotPrecipitationOverHistory <- function(wxUniverse = orfwx::allData(),
                                         plotDate = yesterdate(),
                                         daysWeather = NULL,
                                         twoTicks = TRUE,
                                         fiveTicks = FALSE,
                                         tenTicks = TRUE,
                                         saveToFile = FALSE) {
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
    daysWeatherYear <- format(yesterdate(), "%Y")
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
  
  # saveToFile is only effective if grDevices is available.
  if(!requireNamespace("grDevices", quietly = TRUE)) {
    if(saveToFile) {
      saveToFile = FALSE
      warning("FILE NOT SAVED: Saving file requires the 'grDevices' package.")
    }
  }
  
  if(saveToFile) {
    grDevices::png(paste0(format(plotDate, "%m%d"), "prcp.png"),
                   1024, 512, pointsize = 16)
  }
  
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
  
  if(saveToFile) {
    grDevices::dev.off()
  }
}
