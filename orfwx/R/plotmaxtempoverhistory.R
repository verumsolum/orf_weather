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
#'   to `TRUE`).
#' @param hideContext (optional) Whether or not to hide the lines and labels
#'   providing context to the raw data (defaults to `FALSE`).
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
                                   ranked = TRUE,
                                   hideContext = FALSE,
                                   saveToFile = FALSE) {
  # Pre-compute titles and labels for later legibility:
  plotTitle <- paste("High temperatures on",
                     months(orfwx::searchDate(plotMonth, plotDayOfMonth), 
                            TRUE),
                     plotDayOfMonth,
                     "in Norfolk, VA weather history")
  plotSubtitle <- ifelse(ranked,
                         "In temperature rank order",
                         "In chronological order")
  plotYAxisLabel <- paste("High temperatures on",
                          months(orfwx::searchDate(plotMonth, plotDayOfMonth),
                                 TRUE),
                          plotDayOfMonth,
                          "(°F)")
  
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
  
  if(!hideContext) {
    plotContext <- dplyr::summarise(dayInHistory, 
                                    Coolest = min(MaxTemperature),
                                    Warmest = max(MaxTemperature),
                                    Mean = mean(MaxTemperature),
                                    Median = median(MaxTemperature))
    maxTempPlot <- maxTempPlot +
      ggplot2::geom_hline(yintercept = plotContext[["Coolest"]], 
                          color = "cornflowerblue") +
      ggplot2::geom_hline(yintercept = plotContext[["Warmest"]],
                          color = "firebrick1") +
      ggplot2::geom_hline(yintercept = plotContext[["Median"]],
                          color = "grey50")
  }
  
  maxTempPlot <- maxTempPlot + 
    ggplot2::geom_point()
  if(requireNamespace("ggrepel", quietly = TRUE)) {
    if (ranked) {
      if(!hideContext)  {
        maxTempPlot <- maxTempPlot +
          ggplot2::annotate("text", 
                            x = max(dayInHistory[["Rank"]]), 
                            y = plotContext[["Coolest"]] + 1, 
                            label = paste("Record coldest:",
                                          paste0(plotContext[["Coolest"]],
                                                 "°")), 
                            hjust = 1, 
                            vjust = 0,
                            color = "cornflowerblue",
                            family = "Optima") +
          ggplot2::annotate("text", 
                            x = 1, 
                            y = plotContext[["Warmest"]] - 1, 
                            label = paste("Record hottest:",
                                          paste0(plotContext[["Warmest"]],
                                                 "°")), 
                            hjust = 0, 
                            vjust = 1,
                            color = "firebrick1",
                            family = "Optima") +
          ggplot2::annotate("text", 
                            x = 1, 
                            y = plotContext[["Median"]] + 1, 
                            label = paste("Median:",
                                          paste0(plotContext[["Median"]],
                                                 "°")), 
                            hjust = 0, 
                            vjust = 0,
                            color = "grey50",
                            family = "Optima")
      }
    } else {
      maxTempPlot <- maxTempPlot + 
        ggrepel::geom_text_repel(size = 2.75)
    }
  }
  maxTempPlot <- maxTempPlot +
    ggplot2::ggtitle(plotTitle, plotSubtitle) +
    ggplot2::theme(plot.title = ggplot2::element_text(family = "Optima",
                                                      face = "bold"),
                   plot.subtitle = ggplot2::element_text(family = "Optima")) +
    ggplot2::ylab(plotYAxisLabel)
  maxTempPlot
}
