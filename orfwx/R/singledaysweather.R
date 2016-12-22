#' Create a data frame with a single day's weather
#' 
#' \code{singleDaysWeather} returns a data frame.
#' 
#' There are several functions within the \code{orfwx} package that compare
#' the current day's weather with past years' data. The past years' data are
#' included in the provided datasets. The current year's data may be passed to
#' those functions using \code{singleDaysWeather}.
#' 
#' All of the parameters are optional. Most will be set to \code{NA} if they 
#' are missing. The one exception is \code{dataDate}, which is set to the 
#' current date (as provided by the system), if it has not been explicitly 
#' passed to \code{singleDaysWeather}.  \bold{NOTE:} \code{M} is converted to 
#' \code{NA}, since that resembles the code used by the National Weather 
#' Service for missing data.
#' 
#' @param highTemperature An integer representing the day's high temperature
#'   (in degrees F).
#' @param lowTemperature An integer representing the day's low temperature (in
#'   degrees F).
#' @param averageTemperature A number representing the day's average
#'   temperature (in degrees F).
#' @param precipitationString A character vector representing the day's 
#'   precipitation (in inches) (or the values \code{T} for trace or \code{M} 
#'   for missing value).
#' @param snowfallString A character vector representing the day's
#'   precipitation (in inches) (or the values \code{T} for trace or \code{M} 
#'   for missing value).
#' @param dataDate A date for the data represented (defaults to current day).
#' @return Returns a data frame.
#' @examples
#' singleDaysWeather(55, 34, 44.5, 0.00, 0.0, searchDate(12, 1, 2016))
#' @export
singleDaysWeather <- function(highTemperature = NA,
                              lowTemperature = NA,
                              averageTemperature = NA,
                              precipitationString = NA,
                              snowfallString = NA,
                              dataDate = Sys.Date()) {
  # Sanitize input variables and ensure correct precision
  ## First, ensure that missing values are set to NA.
  if (highTemperature == "M" | 
      is.null(highTemperature) | 
      is.na(highTemperature)) { 
    highTemperature <- NA 
  }
  if (lowTemperature == "M" | 
      is.null(lowTemperature) | 
      is.na(lowTemperature)) { 
    lowTemperature <- NA 
  }
  if (averageTemperature == "M" | 
      is.null(averageTemperature) | 
      is.na(averageTemperature)) { 
    averageTemperature <- NA 
  }
  if (precipitationString == "M" |
      is.null(precipitationString) |
      is.na(precipitationString)) {
    precipitationString <- NA 
  }
  if (snowfallString == "M" |
      is.null(snowfallString) |
      is.na(snowfallString)) { 
    snowfallString <- NA 
  }
  
  ## Then, ensure values are of the proper type.
  highTemperature <- as.integer(highTemperature)
  lowTemperature <- as.integer(lowTemperature)
  averageTemperature <- format(round(as.numeric(averageTemperature), 
                                     digits = 1), 
                               nsmall = 1)
  if (precipitationString != "T" | is.na(precipitationString)) {
    precipitationString <- as.character(
      format(round(as.numeric(precipitationString), digits = 2), nsmall = 2)
      )
  }
  if (snowfallString != "T" | is.na(snowfallString)) {
    snowfallString <- as.character(
      format(round(as.numeric(snowfallString), digits = 1), nsmall = 1)
      )
  }
  dataDate <- as.Date(dataDate)
  
  # Create a data frame from the input variables
  sdw <- data.frame(Date = dataDate,
                    MaxTemperature = highTemperature, 
                    MinTemperature = lowTemperature, 
                    AvgTemperature = averageTemperature, 
                    CsvPrecipitation = precipitationString, 
                    CsvSnowfall = snowfallString)
  return(sdw)
}
