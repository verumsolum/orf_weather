#' Remove added date variable from a data frame
#' 
#' `removeLeapYearAwareDayOfYear` removes from a data frame the
#' `LeapYearAwareDayOfYear` variable which was added by 
#' [computeLeapYearAwareDayOfYear()].
#' 
#' This function may be used to keep this variable from cluttering up display,
#' if the `LeapYearAwareDayOfYear` is no longer needed.
#' 
#' @param originalFrame The data frame from which the 
#'   `LeapYearAwareDayOfYear` variables is removed.
#' @return Returns a data frame.
#' @examples
#' removeLeapYearAwareDayOfYear(computeLeapYearAwareDayOfYear(computeExtraDateVariables(bothStations)))
#' @export
removeLeapYearAwareDayOfYear <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -leapYearAwareDayOfYear)
  return(originalFrame)
}
