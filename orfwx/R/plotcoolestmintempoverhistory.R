#' Plot coolest historical low tempertures on a single date
#' 
#' \code{plotCoolestMinTempOverHistory} creates a barplot with the coolest 
#' low temperatures of one day of the year.
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
#' A barplot is plotted by \code{\link{plotWithManyBars}} with the low 
#' temperatures for all days with a low temperature less than or equal to that 
#' provided by \code{daysWeather}. (In all cases, the ten coolest years are 
#' shown, along with any ties, with additional years added until the year 
#' provided by \code{daysWeather} is shown, and also all years tied with the 
#' same temperature.) The bar for the year provided by \code{daysWeather} (or,
#' if \code{daysWeather} is not provided, the year as of yesterday) is 
#' highlighted with a bar of a different color in the barplot.
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
#' @param tenTicks (optional) Writes tenth ticks (defaults to \code{FALSE}).
#' @return Returns a barplot.
#' @examples
#' plotCoolestMinTempOverHistory(airportData, searchDate(11, 26))  
#' # Returns plot for November 26th
#' @export
plotCoolestMinTempOverHistory <- function(wxUniverse = orfwx::allData(),
                                          plotDate = yesterdate(),
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
    daysWeatherYear <- format(yesterdate(), "%Y")
  }
  
  # Throw away extra information
  wxUniverse <- dplyr::select(wxUniverse, Date, MinTemperature)
  
  # Create a data frame with the weather for this day in history.
  dayInHistory <- dplyr::filter(wxUniverse, 
                                format(Date, "%m%d") == 
                                  format(plotDate, "%m%d"))
  
  # Sort orfTMin by lowTemperature
  dayInHistory <- dplyr::arrange(dayInHistory, MinTemperature)
  
  # If daysWeather has not been passed,
  # or if daysWeather$lowTemperature is in the coldest 10,
  # filter orfTMinSorted to online include those 10 (and ties)
  if (is.null(daysWeather)) {
    dayInHistory <- dplyr::top_n(dayInHistory, -10, MinTemperature)
  } else if (dayInHistory$MinTemperature[10] >= daysWeather$MinTemperature) {
    dayInHistory <- dplyr::top_n(dayInHistory, -10, MinTemperature)
  } else {
    # Otherwise, include all days colder than (or equal to)
    # daysWeather$MinTemperature
    dayInHistory <- dplyr::filter(dayInHistory,
                                  MinTemperature <= 
                                    daysWeather$MinTemperature)
  }
  
  plotWithManyBars(dayInHistory$MinTemperature,
                   dayInHistory,
                   paste("Coolest Low Temperatures on", 
                         format(plotDate, "%b %d"), 
                         "in Norfolk Weather History"),
                   paste("Low temperature on", 
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
