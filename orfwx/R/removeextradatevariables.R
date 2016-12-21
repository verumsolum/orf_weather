#' Remove extra date variables from a data frame
#' 
#' \code{removeExtraDateVariables} removes from a data frame the date
#' variables which have been added by \code{\link{computeExtraDateVariables}}.
#' 
#' These variables are integers for convenience use in filtering, and this
#' function may be used to keep them from cluttering up display.
#' 
#' Errors will result if any of the variables (\code{Year}, \code{Month},
#' \code{DayOfMonth}, and \code{DayOfYear}) have been renamed or deleted.
#' 
#' @param originalFrame The data frame from which the date variables are 
#'   removed.
#' @return Returns a data frame.
#' @examples
#' \dontrun{removeExtraDateVariables(computeExtraDateVariables(bothStations))}
#' @export
removeExtraDateVariables <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -Year, -Month, -DayOfMonth, -DayOfYear)
  return(originalFrame)
}
