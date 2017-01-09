#' Plot month-to-date precipitation
#' 
#' \code{plotMTDPrecipitation} creates a barplot with the precipitation
#' of the month to date.
#' 
#' Three lines are displayed: a red line with the highest month-to-date
#' precipitation recorded by that point in the month, a blue line with the
#' lowest month-to-date precipitation recorded by that point in the month, and
#' a black line with the curent year's month-to-date precipitation.
#' 
#' @return Returns a plot.
#' @examples
#' plotMTDPrecipitation()
#' @export
plotMTDPrecipitation <- function() {
  # DRAFT - not yet suitable for inclusion in package
  ggplot2::ggplot(computeCumulativePrecipitationRecords(showYear = TRUE),
                  aes(DayOfMonth, maxMTDPrecip)) +
    geom_point(color = "firebrick") + 
    geom_line(color = "firebrick") + 
    ggtitle("January month-to-date precipitation") + 
    theme(plot.title = element_text(face = "bold", family = "Optima")) + 
    labs(x = "Day of January", y = "Precipitation (in inches)") + 
    geom_point(aes(y = MTD), color = "black") + 
    geom_line(aes(y = MTD), color = "black") + 
    geom_point(aes(y = minMTDPrecip), color = "blue") + 
    geom_line(aes(y = minMTDPrecip), color = "blue")
  }
