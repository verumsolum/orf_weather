#' Create a barplot with temperature or precipitation data
#' 
#' \code{plotWithManyBars} creates a barplot with the data provided to it.
#' 
#' Missing values in both \code{sortedData} and \code{sortedDataFrame} are
#' discarded (to avoid them being chosen as \code{maxSortedData}). Also, 
#' \code{highlightYear} is checked to ensure it is a valid year.
#' 
#' A barplot is created. Bars are created for all provided data. Unless
#' \code{showAllLabels} is set to \code{TRUE}, labels are only shown for the
#' highest and lowest values (and ties), as well as the \code{highlightYear}'s
#' data.
#' 
#' @param sortedData A vector used for the values to be shown on the barplot. 
#' @param sortedDataFrame A data frame, from which \code{sortedData} has
#'   usually been excerpted.
#' @param titlePlotWmb The title of the barplot
#' @param yAxisLabelPlotWmb The label for the y axis
#' @param plottingPrecip A logical value indicating if we are dealing with
#'   precipitation
#' @param showAllLabels A logical value indicating if we are showing all
#'   labels (if \code{FALSE}, labels will only be shown on the max and min
#'   values and on the year as of yesterday)
#' @param highlightYear The year to highlight in the graph (defaults to the
#'   year as of yesterday)
#' @return Returns a barplot.
#' @examples
#' # How do I show an example?
#' @export
plotWithManyBars <- function(sortedData,
                             sortedDataFrame,
                             titlePlotWmb,
                             yAxisLabelPlotWmb,
                             plottingPrecip = FALSE,
                             showAllLabels = FALSE,
                             highlightYear = format(yesterdate(), "%Y")) {
  # Discard missing values (so they don't become maxSortedData)
  sortedData <- stats::na.omit(sortedData)
  sortedDataFrame <- stats::na.omit(sortedDataFrame)
  # TODO: Handle the edge case where sortedDataFrame has missing year values.
  
  # Ensure highlightYear is a valid year.
  highlightYear <- checkYear(highlightYear)

  # Convenience variables:
  minSortedData <- sortedData[1]
  maxSortedData <- sortedData[length(sortedData)]
  
  # Determine ylim
  yAxisLimitsCalculated <- ifelse(c(plottingPrecip == FALSE, 
                                    plottingPrecip == FALSE),
                                  c(floor((minSortedData - 1) / 5) * 5,
                                    ceiling((maxSortedData) / 5) * 5),
                                  c(0,ceiling((maxSortedData) / 0.5) * 0.5))
  
  # Adapt sortedDataFrame to include year variable
  sortedDataFrame <- computeExtraDateVariables(sortedDataFrame)
  
  # Graph sortedData
  graphics::barplot(as.numeric(sortedData),
                    # Text size for year label
                    cex.names = ifelse(showAllLabels == TRUE, 0.9, 0.6),
                    # If 2, rotate labels perpendicular to axis
                    las = ifelse(showAllLabels == TRUE, 0, 2),
                    main = titlePlotWmb,  # Title
                    ylab = yAxisLabelPlotWmb,  # Label for y axis
                    ylim = yAxisLimitsCalculated,
                    # Do not allow the bars to go outside the plot region 
                    # (i.e., above/below ylim):
                    xpd = FALSE,
                    names.arg = if(showAllLabels == FALSE & 
                                   plottingPrecip == FALSE) {
                      ifelse(sortedDataFrame$Year == highlightYear |
                               sortedData == minSortedData |
                               sortedData == maxSortedData,
                             paste(sortedDataFrame$Year,
                                   "-",
                                   paste0(sortedData, "\u00b0")),
                             "")  # Source of labels for x axis
                      } else {
                        if(plottingPrecip == FALSE) {
                          paste(paste0(sortedData, "\u00b0"), 
                                "\n", 
                                sortedDataFrame$Year)
                          } else {
                            paste(sortedDataFrame$Year,
                                  "-",
                                  paste0(format(sortedData, nsmall = 2), '"'))
                          }
                        },
                    col = ifelse(sortedDataFrame$Year == highlightYear,
                                 "mediumpurple",
                                 "steelblue1"),
                    border = "white")
  
  # Add grid to barplot
  graphics::grid(nx = NA,
                 ny = NULL,
                 lty = "dotted")
}
