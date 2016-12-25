#' Remove logical precipitation variable from a data frame
#' 
#' \code{removeWithPrecipitation} removes from a data frame the
#' \code{WithPrecipitation} variable.
#' 
#' This function may be used to keep the \code{WithPrecipitation} variable
#' from cluttering up display, if it is no longer needed.
#' 
#' @param originalFrame The data frame from which the \code{WithPrecipitation} 
#'   variable is removed.
#' @return Returns a data frame.
#' @examples
#' removeWithPrecipitation(convertCsvToNumericAndLogical(airportData))
#' @export
removeWithPrecipitation <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -WithPrecipitation)
  return(originalFrame)
}
