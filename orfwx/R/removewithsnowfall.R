#' Remove logical snowfall variable from a data frame
#' 
#' \code{removeWithSnowfall} removes from a data frame the
#' \code{WithSnowfall} variable.
#' 
#' This function may be used to keep the \code{WithSnowfall} variable from
#' cluttering up display, if it is no longer needed.
#' 
#' @param originalFrame The data frame from which the \code{WithSnowfall} 
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
