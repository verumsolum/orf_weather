#' Check whether or not the provided year is valid.
#' 
#' `checkYear` returns the year provided to it, unless it is invalid (in
#' which case, it returns the current year).
#' 
#' This function determines that the year in question is:
#' \itemize{
#'   \item not NULL
#'   \item not earlier than 1724 (the year the Fahrenheit scale was developed)
#'   \item not later than the current year
#' }
#' 
#' @param uncheckedYear A value for the year in question.
#' @return Returns a string with the year.
#' @examples
#' \dontrun{checkYear("2016")}  # "2016"
#' \dontrun{checkYear("1776")}  # "2016" (< 1724 becomes current year)
#' \dontrun{checkYear("1984")}  # "1984"
#' \dontrun{checkYear("2020")}  # "2016" (future year becomes current year)
checkYear=function(uncheckedYear){
  # Ensure uncheckedYear is a valid year.
  # Using the year 1724 as the year Gabriel Fahrenheit created scale for
  # measuring temperature and the current year as the boundaries for validity
  if (is.null(uncheckedYear) |
      as.integer(uncheckedYear) < 1724 | 
      as.integer(uncheckedYear) > as.integer(format(Sys.Date(), "%Y"))) {
    # If the year is invalid, warn and set to current year.
    warning("Invalid year provided. Setting to current year and continuing.")
    uncheckedYear <- format(Sys.Date(), "%Y")
  }
  return(uncheckedYear)
}
