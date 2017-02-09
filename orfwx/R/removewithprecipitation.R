#' Remove logical precipitation variable from a data frame
#' 
#' `removeWithPrecipitation` removes from a data frame the
#' `WithPrecipitation` variable.
#' 
#' This function may be used to keep the `WithPrecipitation` variable
#' from cluttering up display, if it is no longer needed.
#' 
#' @param originalFrame The data frame from which the `WithPrecipitation` 
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
