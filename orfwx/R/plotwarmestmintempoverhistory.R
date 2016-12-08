#' Plot warmest historical low tempertures on a single date
#' 
#' \code{plotWarmestMinTempOverHistory} returns a barplot with the warmest 
#' low temperatures of one day of the year.
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
  orfTMinSorted <- arrange(orfTMin, desc(lowTemperature))
  if(orfTMinSorted$lowTemperature[10] <= daysWeather$MinTemperature) {
    orfTMinSorted <- filter(orfTMinSorted, 
                            lowTemperature >= orfTMinSorted$lowTemperature[10])
  } else {
    orfTMinSorted <- filter(orfTMinSorted, 
                            lowTemperature >= daysWeather$MinTemperature)
  }
  
  orfTMinSorted <- arrange(orfTMinSorted, lowTemperature, as.integer(year))
  
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
