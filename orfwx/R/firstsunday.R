#' Find the first Sunday in a month.
#' 
#' `firstSunday` finds the date of the first Sunday in a month.
#' 
#' This function takes the provided month and year and returns the date of the
#' first Sunday of the month. For example, January 2017 begins with a Sunday, so
#' `firstSunday(1, 2017)` returns 1. But February 2017 begins with a
#' Wednesday, so `firstSunday(2, 2017)` returns 5, because February 5th is
#' the first Sunday of the month.
#' 
#' @param fsMonth An integer representing the month of the year (1=January, 
#'   12=December) for which the first Sunday is desired.
#' @param fsYear An integer representing the year of the month for which the
#'   first Sunday of the month is desired.
#' @return Integer
#' @examples
#' firstSunday(1, 2017) # Returns 1
#' firstSunday(2, 2017) # Returns 5
#' @export
firstSunday <- function(fsMonth, fsYear){
  for(d in 1:7) {
    if(weekdays(as.Date(paste0(fsYear, "-", fsMonth, "-0", d))) == "Sunday") {
      return(d)
    }
  }
}
