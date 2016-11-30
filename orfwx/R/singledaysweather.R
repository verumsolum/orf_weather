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
  precipitation <- as.character(format(round(precipitation, digits = 2), 
                                       nsmall = 2))
  snowfall <- as.character(format(round(snowfall, digits = 1), nsmall = 1))
  
  # Create a data frame from the input variables
  sdw <- data.frame(MaxTemperature = highTemperature, 
                    MinTemperature = lowTemperature, 
                    AvgTemperature = averageTemperature, 
                    Precipitation = precipitation, 
                    Snowfall = snowfall)
  return(sdw)
}
