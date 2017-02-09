#' Remove logical snowfall variable from a data frame
#' 
#' `removeWithSnowfall` removes from a data frame the
#' `WithSnowfall` variable.
#' 
#' This function may be used to keep the `WithSnowfall` variable from
#' cluttering up display, if it is no longer needed.
#' 
#' @param originalFrame The data frame from which the `WithSnowfall` 
#'   variable is removed.
#' @return Returns a data frame.
#' @examples
#' removeWithSnowfall(convertCsvToNumericAndLogical(airportData))
#' @export
removeWithSnowfall <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -WithSnowfall)
  return(originalFrame)
}
