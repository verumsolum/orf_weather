#' Create a data frame with a single day's weather
#' 
#' \code{singleDaysWeather} returns a data frame.
#' 
#' Details section to be written.
#' 
#' @param highTemperature An integer representing the day's high temperature
#'   (in °F).
#' @param lowTemeprature An integer representing the day's low temperature (in
#'   °F).
#' @param averageTemperature A number representing the day's average
#'   temperature (in °F).
#' @param precipitation A number representing the day's precipitation (in 
#'   inches).
#' @param snowfall A number representing the day's precipitation (in inches).
#' @return Returns a data frame.
#' @examples
#' singleDaysWeather(55, 34, 44.5, 0.00, 0.0)
#' @export
singleDaysWeather <- function(highTemperature = NULL,
                              lowTemperature = NULL,
                              averageTemperature = NULL,
                              precipitation = NULL,
                              snowfall = NULL) {
  # Sanitize input variables
  highTemperature = as.integer(highTemperature)
  lowTemperature = as.integer(lowTemperature)
  averageTemperature = as.numeric(averageTemperature)
  precipitation = as.numeric(precipitation)
  snowfall = as.numeric(snowfall)
}
