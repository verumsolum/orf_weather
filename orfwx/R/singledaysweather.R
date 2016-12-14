#' Create a data frame with a single day's weather
#' 
#' \code{singleDaysWeather} returns a data frame.
#' 
#' There are several functions within the \code{orfwx} package that compare
#' the current day's weather with past years' data. The past years' data are
#' included in the provided \code{\link{mutatedBothStations}} dataset. The 
#' current year's data is passed to those functions using 
#' \code{singleDaysWeather}.
#' 
#' All of the parameters are optional. Most will be set to \code{NA} if they 
#' are missing. The one exception is \code{dataDate}, which is set to the 
#' current date (as provided by the system), if it has not been explicitly 
#' passed to \code{singleDaysWeather}.
#' 
#' \strong{NOTE:} The values for \code{precipitation} and for \code{snowfall} 
#' are coerced into numeric values. So, if one passes \code{"T"} (for
#' \emph{trace} precipitation or snowfall), that ends up changed to 
#' \code{NA}.
#' 
#' @param highTemperature An integer representing the day's high temperature
#'   (in °F).
#' @param lowTemperature An integer representing the day's low temperature (in
#'   °F).
#' @param averageTemperature A number representing the day's average
#'   temperature (in °F).
#' @param precipitation A number representing the day's precipitation (in 
#'   inches).
#' @param snowfall A number representing the day's precipitation (in inches).
#' @param dataDate A date for the data represented (defaults to current day).
#' @return Returns a data frame.
#' @examples
#' singleDaysWeather(55, 34, 44.5, 0.00, 0.0, searchDate(12, 1, 2016))
#' @export
singleDaysWeather <- function(highTemperature = NA,
                              lowTemperature = NA,
                              averageTemperature = NA,
                              precipitation = NA,
                              snowfall = NA,
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
  if (precipitation == "M" | is.null(precipitation) | is.na(precipitation)) { 
    precipitation <- NA 
  }
  if (snowfall == "M" | is.null(snowfall) | is.na(snowfall)) { 
    snowfall <- NA 
  }
  
  ## Then, ensure values are of the proper type.
  highTemperature <- as.integer(highTemperature)
  lowTemperature <- as.integer(lowTemperature)
  averageTemperature <- format(round(as.numeric(averageTemperature), 
                                     digits = 1), 
                               nsmall = 1)
  precipitation <- as.character(format(round(as.numeric(precipitation), 
                                             digits = 2), 
                                       nsmall = 2))
  snowfall <- as.character(format(round(as.numeric(snowfall), digits = 1), 
                                  nsmall = 1))
  dataDate <- as.Date(dataDate)
  
  # Create a data frame from the input variables
  sdw <- data.frame(Date = dataDate,
                    MaxTemperature = highTemperature, 
                    MinTemperature = lowTemperature, 
                    AvgTemperature = averageTemperature, 
                    CsvPrecipitation = precipitation, 
                    CsvSnowfall = snowfall)
  
  # Create two new variables from CsvPrecipitation
  sdw <- dplyr::mutate(sdw,
                       PrecipitationInches =
                         dplyr::if_else(is.na(CsvPrecipitation),
                                        NA_real_,
                                        dplyr::if_else(CsvPrecipitation == "T",
                                                       0,
                                                       as.numeric(as.character(
                                                         CsvPrecipitation)))),
                       WithPrecipitation = 
                         dplyr::if_else(is.na(CsvPrecipitation),
                                        NA,
                                        dplyr::if_else(
                                          CsvPrecipitation == "T",
                                          TRUE,
                                          as.logical(PrecipitationInches))))

  # Create two new variables from CsvSnowfall
  sdw <- dplyr::mutate(sdw,
                       SnowfallInches = 
                         dplyr::if_else(is.na(CsvSnowfall),
                                        NA_real_,
                                        dplyr::if_else(CsvSnowfall == "T",
                                                       0,
                                                       as.numeric(as.character(
                                                         CsvSnowfall)))),
                       WithSnowfall = 
                         dplyr::if_else(is.na(CsvSnowfall),
                                        NA,
                                        dplyr::if_else(CsvSnowfall == "T",
                                                       TRUE,
                                                       as.logical(
                                                         SnowfallInches))))
  return(sdw)
}
