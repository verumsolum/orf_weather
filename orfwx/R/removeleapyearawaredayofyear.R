#' Remove extra date variables from a data frame
#' 
#' \code{removeLeapYearAwareDayOfYear} removes from a data frame the
#' \code{LeapYearAwareDayOfYear} variable which was added by 
#' \code{\link{computeLeapYearAwareDayOfYear}}.
#' 
#' This function may be used to keep them from cluttering up display, if the
#' \code{LeapYearAwareDayOfYear} is no longer needed.
#' 
#' @param originalFrame The data frame from which the 
#'   \code{LeapYearAwareDayOfYear} variables is removed.
#' @return Returns a data frame.
#' @examples
#' \dontrun{
#' removeLeapYearAwareDayOfYear(computeLeapYearAwareDayOfYear(bothStations))
#' }
#' @export
removeLeapYearAwareDayOfYear <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -LeapYearAwareDayOfYear)
  return(originalFrame)
}
