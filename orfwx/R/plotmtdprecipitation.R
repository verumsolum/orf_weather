#' Plot month-to-date precipitation
#' 
#' `plotMTDPrecipitation` creates a plot with the precipitation
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
#' @param saveToFile (optional) Writes plot to a PNG file (defaults to 
#'   `FALSE`).
#' @param showLeapDay (optional) Whether or not to show data for February 29th
#'   (defaults to `FALSE`, unless the current year is a leap year).
#' @param showLastCompleteMonth (optional) Whether to show data from the last
#'   complete month or whether to show the month in progress (defaults to
#'   `FALSE`).
#' @return Returns a plot.
#' @examples
#' \dontrun{
#' plotMTDPrecipitation()}
#' @export
plotMTDPrecipitation <- function(plotMonth = format(orfwx::yesterdate(), 
                                                    "%m"),
                                 saveToFile = FALSE,
                                 showLeapDay = 
                                   orfwx::is.leapYear(as.integer(format(
                                     orfwx::yesterdate(), "%Y"))),
                                 showLastCompleteMonth = FALSE) {
  # DRAFT - not yet suitable for inclusion in package
  plotMonth <- as.integer(plotMonth)
  currentMonth <- as.integer(format(orfwx::yesterdate(), "%m"))
  plotYear <- as.integer(format(orfwx::yesterdate(), "%Y"))
  if(currentMonth < plotMonth) {
    # If we haven't yet had the month to be displayed this calendar year,
    # then use last year.
    plotYear <- plotYear - 1
  } else if((currentMonth == plotMonth) & showLastCompleteMonth) {
    # If we're talking about the current month and
    # showLastCompleteMonth is TRUE…
    nextDaysMonth <- as.integer(format(Sys.Date(), "%m"))
    if(nextDaysMonth == currentMonth) {
      # If today's month and yesterday's month are the same,
      # this is an incomplete month, so we should use last year.
      plotYear <- plotYear - 1
    }
  }
  plotYear <- as.character(plotYear)
  col2legend <- c("Maximum" = "firebrick", 
                  "Normal" = "darkgreen", 
                  "Current" = "black", 
                  "Minimum" = "blue")
  gmtd <- ggplot2::ggplot(orfwx::computeCumulativePrecipRecords(
                            ccprMonth = plotMonth,
                            showYear = TRUE,
                            includeNormals = TRUE,
                            showLeapDay = showLeapDay,
                            showLastCompleteMonth = showLastCompleteMonth),
                          ggplot2::aes(DayOfMonth, 
                                       maxMTDPrecip, 
                                       color = "Maximum")) +
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
    ggplot2::geom_point(ggplot2::aes(y = MTDNormal, color = "Normal")) + 
    ggplot2::geom_line(ggplot2::aes(y = MTDNormal, color = "Normal")) + 
    ggplot2::geom_point(ggplot2::aes(y = minMTDPrecip, color = "Minimum")) + 
    ggplot2::geom_line(ggplot2::aes(y = minMTDPrecip, color = "Minimum")) + 
    ggplot2::geom_text(ggplot2::aes(y = minMTDPrecip, 
                                    label = minMTDYear, 
                                    color = "Minimum"), 
                       nudge_y = -0.5, 
                       angle = 90, 
                       size = 3,
                       color = "black") +
    ggplot2::geom_point(ggplot2::aes(y = MTD, color = "Current")) + 
    ggplot2::geom_line(ggplot2::aes(y = MTD, color = "Current")) + 
    ggplot2::scale_color_manual(name = "Legend", 
                                values = col2legend, 
                                breaks = c("Maximum", 
                                           "Normal", 
                                           "Current", 
                                           "Minimum"), 
                                labels = c("Maximum\n(1874-present)", 
                                           "Normal\n(1981-2010)",
                                           plotYear, 
                                           "Minimum\n(1874-present)")) +
    ggplot2::scale_x_continuous(breaks = seq(orfwx::firstSunday(plotMonth,
                                                                plotYear), 
                                             31, 
                                             7),
                                expand = c(0.02, 0.02))
  if(saveToFile) {
    ggplot2::ggsave(paste0(orfwx::padSingleDigitInteger(plotMonth), "pmtd.png"),
                    device = "png",
                    width = 10.24,
                    height = 5.12,
                    dpi = 100)
  } else {
    gmtd
  }
}
