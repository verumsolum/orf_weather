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
#' @param plotMonth (optional) The month for which precipitation records are
#'   desired. Defaults to the current month (except on the 1st of the month,
#'   when it defaults to the previous month).
#' @return Returns a plot.
#' @examples
#' plotMTDPrecipitation()
#' @export
plotMTDPrecipitation <- function(plotMonth = format(orfwx::yesterdate(), 
                                                    "%m")) {
  # DRAFT - not yet suitable for inclusion in package
  plotMonth <- as.integer(plotMonth)
  col2legend <- c("Maximum" = "firebrick", 
                  "2017" = "black", 
                  "Minimum" = "blue")
  ggplot2::ggplot(orfwx::computeCumulativePrecipitationRecords(
                    showYear = TRUE),
                  ggplot2::aes(DayOfMonth, maxMTDPrecip, color = "Maximum")) +
    ggplot2::geom_point(ggplot2::aes(color = "Maximum")) + 
    ggplot2::geom_line(ggplot2::aes(color = "Maximum")) + 
    ggplot2::geom_text(ggplot2::aes(label = maxMTDYear, color = "Maximum"), 
                       nudge_y = 0.5, 
                       angle = 90, 
                       size = 3,
                       color = "black") +
    ggplot2::ggtitle(paste(month.name[plotMonth], 
                           "month-to-date precipitation")) + 
    ggplot2::theme(plot.title = ggplot2::element_text(face = "bold",
                                                      family = "Optima")) + 
    ggplot2::labs(x = paste("Day of", month.name[plotMonth]),
                  y = "Precipitation (in inches)") + 
    ggplot2::geom_point(ggplot2::aes(y = MTD, color = "2017")) + 
    ggplot2::geom_line(ggplot2::aes(y = MTD, color = "2017")) + 
    ggplot2::geom_point(ggplot2::aes(y = minMTDPrecip, color = "Minimum")) + 
    ggplot2::geom_line(ggplot2::aes(y = minMTDPrecip, color = "Minimum")) + 
    ggplot2::geom_text(ggplot2::aes(y = minMTDPrecip, 
                                    label = minMTDYear, 
                                    color = "Minimum"), 
                       nudge_y = -0.5, 
                       angle = 90, 
                       size = 3,
                       color = "black") +
    ggplot2::scale_color_manual(name = "Legend", 
                                values = col2legend, 
                                breaks = c("Maximum", "2017", "Minimum"), 
                                labels = c("Maximum\n(1874-present)", 
                                           "2017", 
                                           "Minimum\n(1874-present)"))
  }
