#' Remove extra date variables from a data frame
#' 
#' `removeExtraDateVariables` removes from a data frame the date
#' variables which have been added by [computeExtraDateVariables()].
#' 
#' These variables are integers for convenience use in filtering, and this
#' function may be used to keep them from cluttering up display.
#' 
#' Errors will result if any of the variables (`Year`, `Month`,
#' `DayOfMonth`, and `DayOfYear`) have been renamed or deleted.
#' 
#' @param originalFrame The data frame from which the date variables are 
#'   removed.
#' @return Returns a data frame.
#' @examples
#' removeExtraDateVariables(computeExtraDateVariables(airportData))
#' @export
removeExtraDateVariables <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -Year, -Month, -DayOfMonth, -DayOfYear)
  return(originalFrame)
}
