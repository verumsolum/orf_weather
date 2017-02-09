#' Plot historical high tempertures on a single date
#' 
#' `plotMaxTempOverHistory` creates a barplot with the high temperatures
#' of one day each year.
#' 
#' If `daysWeather` is passed (usually using 
#' [singleDaysWeather()]), the function ensures that its weather is 
#' for the same date as that provided by `plotDate` (either passed to the 
#' function or the default value of the current system date). If they do not 
#' match, the function terminates with an error message.
#' 
#' The data from `daysWeather` is added to that provided by 
#' `wxUniverse` (by default, [allData()]) and the weather
#' on the same date each year is compared.
#' 
#' A barplot is plotted by [plotWithManyBars()] with the high 
#' temperatures for the same date in all years. The bar for the year provided
#' by `daysWeather` (or, if `daysWeather` is not provided, the
#' year as of yesterday) is highlighted with a bar of a different color in the 
#' barplot.
#' 
#' @param wxUniverse (optional) The data frame containing the weather history
#'   to be searched (defaults to `allData`).
#' @param plotDate (optional) The date to be searched for, defaulting to
#'   yesterday's date.
#' @param daysWeather (optional) The weather for a date not yet included in
#'   the `wxUniverse` data frame, usually passed by the
#'   `singleDaysWeather` function.
#' @param twoTicks (optional) Writes half ticks (defaults to `TRUE`).
#' @param fiveTicks (optional) Writes fifth ticks (defaults to `FALSE`).
#' @param tenTicks (optional) Writes tenth ticks (defaults to `TRUE`).
#' @param saveToFile (optional) Writes plot to a PNG file (defaults to 
#'   `FALSE`).
#' @return Returns a barplot.
#' @examples
#' plotMaxTempOverHistory(airportData, searchDate(11, 26))  
#' # Returns plot for November 26th
#' @export
plotMaxTempOverHistory <- function(wxUniverse = orfwx::allData(),
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
  
  # Throw away extra information
  wxUniverse <- dplyr::select(wxUniverse, Date, MaxTemperature)
  
  # Create a data frame with the weather for this day in history.
  dayInHistory <- dplyr::filter(wxUniverse, 
                         format(Date, "%m%d") == format(plotDate, "%m%d"))
  
  # Sort orfTMax by highTemperature
  dayInHistory <- dayInHistory[order(dayInHistory$MaxTemperature), ]
  
  # saveToFile is only effective if grDevices is available.
  if(!requireNamespace("grDevices", quietly = TRUE)) {
    if(saveToFile) {
      saveToFile = FALSE
      warning("FILE NOT SAVED: Saving file requires the 'grDevices' package.")
    }
  }
  
  if(saveToFile) {
    grDevices::png(paste0(format(plotDate, "%m%d"), "tmax.png"),
                   1024, 512, pointsize = 16)
  }
  
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
  
  if(saveToFile) {
    invisible(grDevices::dev.off())
  }
}
