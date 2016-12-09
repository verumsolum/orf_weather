#' Plot warmest historical low tempertures on a single date
#' 
#' \code{plotWarmestMinTempOverHistory} returns a barplot with the warmest 
#' low temperatures of one day of the year.
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
#' A barplot is plotted by \code{\link{plotWithManyBars}} with the low 
#' temperatures for all days with a low temperature greater than or equal to 
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
#' plotWarmestMinTempOverHistory(searchDate(11, 27))  # plot for November 27th
#' @export
plotWarmestMinTempOverHistory <- function(plotDate = searchDate(),
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
  
  # Make a data frame with only the year and minimum temperature (orftmin)
  orfTMin <- data.frame("year" = as.integer(format(dayInHistory$Date, "%Y")),
                        "lowTemperature" = dayInHistory$MinTemperature)
  
  # If daysWeather is not NULL, add data for current year:
  if (!is.null(daysWeather)) {
    daysWeatherYear <- format(daysWeather$Date, "%Y")
    # todayTMin is temp data frame with current observations
    todayTMin <- data.frame("year" = format(plotDate, "%Y"),
                            "lowTemperature" = daysWeather$MinTemperature)  
    orfTMin <- rbind(orfTMin, todayTMin) # Merge with historical observations
  } else {
    daysWeatherYear <- format(Sys.Date(), "%Y")
  }
  # Sort orfTMin by lowTemperature
  orfTMinSorted <- dplyr::arrange(orfTMin, dplyr::desc(lowTemperature))
  if(orfTMinSorted$lowTemperature[10] <= daysWeather$MinTemperature) {
    orfTMinSorted <- dplyr::filter(orfTMinSorted,
                                   lowTemperature >= 
                                     orfTMinSorted$lowTemperature[10])
  } else {
    orfTMinSorted <- dplyr::filter(orfTMinSorted,
                                   lowTemperature >= 
                                     daysWeather$MinTemperature)
  }
  
  orfTMinSorted <- dplyr::arrange(orfTMinSorted, 
                                  lowTemperature, 
                                  as.integer(year))
  
  plotWithManyBars(orfTMinSorted$lowTemperature,
                   orfTMinSorted,
                   paste("Warmest Low Temperatures on", 
                         format(plotDate, "%b %d"), 
                         "in Norfolk Weather History"),
                   paste("Low temperature on", 
                         format(plotDate, "%b %d"), 
                         "(in °F)"),
                   showAllLabels = TRUE,
                   highlightYear = daysWeatherYear
  )
  
  if (!requireNamespace("Hmisc", quietly = TRUE)) {
    # Hmisc::minor.tick(nx = 1,
    #                   ny = 5,
    #                   tick.ratio = 0.5)
    # Hmisc::minor.tick(nx = 1,
    #                   ny = 10,
    #                   tick.ratio = 0.33)
    Hmisc::minor.tick(nx = 1,
                      ny = 2,
                      tick.ratio = 0.67)
  }
}
