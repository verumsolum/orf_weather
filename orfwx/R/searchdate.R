#' Create a date from a numeric month and day, for use in searches.
#' 
#' \code{searchDate} returns a date. If not provided with a numeric month and
#' day, the current date from the system clock will be used.
#' 
#' This function passes \code{searchMonth} and \code{searchDay} through
#' \code{padSingleDigitInteger} and uses them to create a string.
#' That string is converted to a date.
#' 
#' Errors will result from invalid months or most invalid dates.
#' 
#' @param searchMonth An integer between 1 [Jan] and 12 [Dec] (inclusive).
#' @param searchDay An integer between 1 and 31 for the day of the month.
#' @return Returns a date.
#' @examples
#' searchDate(1, 1)  # January 1st
#' searchDate(7, 4)  # July 4th
#' searchDate(12, 31)  # December 31st
#' searchDate()  # The current date
#' @export
searchDate <- function(searchMonth = format(Sys.Date(), "%m"),
                       searchDay = format(Sys.Date(), "%d"),
                       searchYear = format(Sys.Date(), "%Y")) {
  # Convert inputs to integers
  searchMonth <- as.integer(searchMonth)
  searchDay <- as.integer(searchDay)
  searchYear <- as.integer(searchYear)
  
  # Fail if given invalid inputs
  if(searchMonth < 0) stop("searchMonth is negative")
  if(searchMonth == 0) stop("searchMonth is zero")
  if(searchMonth > 12) stop("searchMonth is greater than 12")
  if(searchDay < 0) stop("searchDay is negative")
  if(searchDay == 0) stop("searchDay is zero")
  if(searchDay > 31) stop("searchDay is greater than 31")
  if(searchMonth == 2 & 
     searchDay > 29) {
      stop("February does not have this many days.")
  }
  if(searchDay == 31) {
    if(searchMonth == 4 | 
       searchMonth == 6 | 
       searchMonth == 9 | 
       searchMonth == 11) stop("This month does not have 31 days.")
  }
  
  # Otherwise, proceed to return a date.
  searchDateString <- paste0(as.character(searchYear),
                             "-",
                             padSingleDigitInteger(searchMonth),
                             "-",
                             padSingleDigitInteger(searchDay))
  as.Date(searchDateString)
}
