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
  ggplot2::ggplot(orfwx::computeCumulativePrecipitationRecords(
                    showYear = TRUE),
                  ggplot2::aes(DayOfMonth, maxMTDPrecip)) +
    ggplot2::geom_point(color = "firebrick") + 
    ggplot2::geom_line(color = "firebrick") + 
    ggplot2::ggtitle("January month-to-date precipitation") + 
    ggplot2::theme(plot.title = ggplot2::element_text(face = "bold",
                                                      family = "Optima")) + 
    ggplot2::labs(x = "Day of January", y = "Precipitation (in inches)") + 
    ggplot2::geom_point(ggplot2::aes(y = MTD), color = "black") + 
    ggplot2::geom_line(ggplot2::aes(y = MTD), color = "black") + 
    ggplot2::geom_point(ggplot2::aes(y = minMTDPrecip), color = "blue") + 
    ggplot2::geom_line(ggplot2::aes(y = minMTDPrecip), color = "blue")
  }
