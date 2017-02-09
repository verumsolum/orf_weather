#' Add extra date variables to a data frame
#' 
#' `computeExtraDateVariables` appends extra date variables to a data frame.
#' 
#' These variables are integers for convenience use in filtering:
#' 
#' * `Year`: The year
#' * `Month`: The month
#' * `DayOfMonth`: The date (1-31)
#' * `DayOfYear`: The so-called \dQuote{julian day} as an integer (1-366)
#' 
#' @param originalFrame The data frame to which the date variables are 
#'   appended.
#' @return Returns a data frame.
#' @examples
#' computeExtraDateVariables(airportData)
#' @export
computeExtraDateVariables <- function(originalFrame){
  originalFrame <- dplyr::mutate(
    originalFrame,
    Year = as.integer(strftime(Date,
                               format = "%Y")),
    Month = as.integer(strftime(Date,
                                format = "%m")),
    DayOfMonth = as.integer(strftime(Date,
                                     format = "%d")),
    DayOfYear = as.integer(strftime(Date,
                                    format = "%j"))
  )
  return(originalFrame)
}
