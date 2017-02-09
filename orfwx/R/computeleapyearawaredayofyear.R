#' Add variable with a number for each date in the year to a data frame
#' 
#' `computeLeapYearAwareDayOfYear` appends a variable with a version of
#' `DayOfYear` which is altered to allow date comparison between
#' leap years and non-leap years.
#' 
#' In non-leap years, where the month is greater than or equal to 3,
#' `LeapYearAwareDayOfYear` will be `DayOfYear + 1`.
#' 
#' In leap years, and in January and February of all years,
#' `LeapYearAwareDayOfYear` and `DayOfYear` will be equal.
#' 
#' This will stop with an error if the `DayOfYear` variable is not 
#' present in `originalFrame`. Usually, this means having run
#' `computeExtraDateVariables` first.
#' 
#' @param originalFrame The data frame to which the 
#'   `LeapYearAwareDayOfYear` variable is appended.
#' @return Returns a data frame.
#' @examples
#' computeLeapYearAwareDayOfYear(computeExtraDateVariables(airportData))
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
