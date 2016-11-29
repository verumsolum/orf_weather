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
singleDaysWeather <- function(highTemperature = NA,
                              lowTemperature = NA,
                              averageTemperature = NA,
                              precipitation = NA,
                              snowfall = NA) {
  # Sanitize input variables and ensure correct precision
  highTemperature <- as.integer(highTemperature)
  lowTemperature <- as.integer(lowTemperature)
  averageTemperature <- round(averageTemperature, digits = 1)
  precipitation <- paste0(" ", as.character(round(precipitation, digits = 2)))
  snowfall <- paste0(" ", as.character(round(snowfall, digits = 1)))
  
  # Create a data frame from the input variables
  sdw <- data.frame(highTemperature, 
                    lowTemperature, 
                    averageTemperature, 
                    precipitation, 
                    snowfall)
  return(sdw)
}
