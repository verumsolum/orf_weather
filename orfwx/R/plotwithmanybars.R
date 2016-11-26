#' Create a barplot with temperature or precipitation data
#' 
#' \code{plotWithManyBars} returns a barplot with the data provided to it.
#' 
#' This code makes my head hurt, because it was some of the earliest R code I
#' wrote, when I was mostly in make-it-work mode, with huge gaps in my
#' understanding of R (and of barplot particularly)
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
#'   values and on the current year)
#' @return Returns a barplot.
#' @examples
#' # How do I show an example?
#' @export
plotWithManyBars <- function(sortedData,
                             sortedDataFrame,
                             titlePlotWmb,
                             yAxisLabelPlotWmb,
                             plottingPrecip = FALSE,
                             showAllLabels = FALSE) {
  # Discard missing values (so they don't become maxSortedData)
  sortedData <- na.omit(sortedData)
  sortedDataFrame <- na.omit(sortedDataFrame)
  # TODO: Handle the edge case where sortedDataFrame has missing year values.
  
  # Convenience variables:
  minSortedData <- sortedData[1]
  maxSortedData <- sortedData[length(sortedData)]
  
  # Determin ylim
  yAxisLimitsCalculated <- ifelse(c(plottingPrecip == FALSE, plottingPrecip == FALSE),
                                  c(floor((minSortedData - 1) / 5) * 5,
                                    ceiling((maxSortedData) / 5) * 5),
                                  c(0,ceiling((maxSortedData) / 0.5) * 0.5))
  
  # Graph sortedData
  barplot(as.numeric(sortedData),
          # cex.names = 0.6,  # Smaller text for year label
          cex.names = ifelse(showAllLabels == TRUE, 0.9, 0.6),
          # las = 2, # rotate labels perpendicular to axis
          las = ifelse(showAllLabels == TRUE, 0, 2),
          main = titlePlotWmb,  # Title
          ylab = yAxisLabelPlotWmb,  # Label for y axis
          ylim = yAxisLimitsCalculated,
          #           ylim = c(floor((minSortedData - 1) / 5) * 5,
          #                    ceiling((maxSortedData + 1) /5) * 5),  # Limits of y axis  # TODO: Automatic limits
          xpd = FALSE,  # Do not allow the bars to go outside the plot region (i.e., above/below ylim)
          # names.arg = ifelse(sortedDataFrame$year == 2016 |
          #                      sortedData == minSortedData |
          #                      sortedData == maxSortedData, 
          #                    paste(sortedDataFrame$year, "-", paste0(sortedData, "°")),
          #                    ""),  # Source of labels for x axis
          names.arg = if(showAllLabels == FALSE & plottingPrecip == FALSE) { 
            ifelse(sortedDataFrame$year == 2016 |
                     sortedData == minSortedData |
                     sortedData == maxSortedData, 
                   paste(sortedDataFrame$year, "-", paste0(sortedData, "°")),
                   "")  # Source of labels for x axis
          } else {
            # paste(sortedDataFrame$year, "-", paste0(sortedData, "°"))
            if(plottingPrecip == FALSE) {
              paste(paste0(sortedData, "°"), "\n", sortedDataFrame$year)
            } else {
              paste(sortedDataFrame$year, "-", paste0(format(sortedData, nsmall = 2), '"'))
            }
          },
          col = ifelse(sortedDataFrame$year == 2016, "mediumpurple", "steelblue1"),
          border = "white")
  grid(nx = NA,
       ny = NULL,
       lty = "dotted")
}
