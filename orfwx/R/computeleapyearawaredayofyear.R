#' Add variable for temperature spread to a data frame
#' 
#' \code{computeLeapYearAwareDayOfYear} appends a variable with a version of
#' \code{DayOfYear} which is altered to allow date comparison between
#' leap years and non-leap years.
#' 
#' In non-leap years, where the month is greater than or equal to 3,
#' \code{LeapYearAwareDayOfYear} will be \code{DayOfYear + 1}.
#' 
#' In leap years, and in January and February of all years,
#' \code{LeapYearAwareDayOfYear} and \code{DayOfYear} will be equal.
#' 
#' The difference between \code{MaxTemperature} and \code{MinTemperature} is
#' computed and added to a \code{TemperatureSpread} variable in the data frame.
#' 
#' This will stop with an error if those columns are not present in
#' \code{originalFrame}.
#' 
#' @param originalFrame The data frame to which the \code{TemperatureSpread} 
#'   variable is appended.
#' @return Returns a data frame.
#' @examples
#' \dontrun{computeLeapYearAwareDayOfYear(bothStations)}
#' @export
computeLeapYearAwareDayOfYear <- function(originalFrame){
  originalFrame <- dplyr::mutate(
    originalFrame,
    leapYearAwareDayOfYear = ifelse(Month >= 3 & !orfwx::is.leapYear(Year),
                                    DayOfYear + 1,
                                    DayOfYear)
  )
  return(originalFrame)
}
