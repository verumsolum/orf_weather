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
#' @param plotMonth (optional) The month (1=January, 12=December) of the date 
#'   to be searched for (defaults to the month of `yesterdate`).
#' @param plotDayOfMonth (optional) The day of the month (1-31) to be searched 
#'   for (defaults to the day of the month of `yesterdate`).
#' @param ranked (optional) Weather or not to order the plot by rank (defaults
#'   to `FALSE`).
#' @param saveToFile (optional) Writes plot to a PNG file (defaults to 
#'   `FALSE`).
#' @return Returns a barplot.
#' @examples
#' plotMaxTempOverHistory(airportData, 11, 26)  
#' # Returns plot for November 26th
#' @export
plotMaxTempOverHistory <- function(wxUniverse = orfwx::allData(),
                                   plotMonth =  format(orfwx::yesterdate(), 
                                                       "%m"),
                                   plotDayOfMonth = format(orfwx::yesterdate(), 
                                                           "%d"),
                                   ranked = FALSE,
                                   saveToFile = FALSE) {
  # Create a data frame with the weather for this day in history.
  dayInHistory <- orfwx::dayEachYear(wxUniverse, plotMonth, plotDayOfMonth) %>%
    dplyr::select(Date, Year, MaxTemperature)
  if(ranked) {
    dayInHistory <- dayInHistory %>%
      dplyr::mutate(Rank = rank(MaxTemperature, 
                                na.last = "keep", 
                                ties.method = "first")) %>%
      dplyr::arrange(Rank)
    maxTempPlot <- ggplot2::ggplot(dayInHistory, 
                                   ggplot2::aes(Rank, 
                                                MaxTemperature, 
                                                label = Year))
  } else {
    maxTempPlot <- ggplot2::ggplot(dayInHistory, 
                                   ggplot2::aes(Year, 
                                                MaxTemperature, 
                                                label = Year))
  }
  
  maxTempPlot <- maxTempPlot + 
    ggplot2::geom_point()
  if(requireNamespace("ggrepel", quietly = TRUE)) {
    if (ranked) {
      # TODO: Label min, max, &c.
    } else {
      maxTempPlot <- maxTempPlot + 
        ggrepel::geom_text_repel(size = 2.75)
    }
  }
  maxTempPlot
}
