#' Remove snowfall amount variable from a data frame
#' 
#' `removeSnowfallInches` removes from a data frame the
#' `SnowfallInches` variable.
#' 
#' This function may be used to keep the `SnowfallInches` variable from
#' cluttering up display, if it is no longer needed.
#' 
#' @param originalFrame The data frame from which the `SnowfallInches`
#'   variable is removed.
#' @return Returns a data frame.
#' @examples
#' removeSnowfallInches(convertCsvToNumericAndLogical(airportData))
#' @export
removeSnowfallInches <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -SnowfallInches)
  return(originalFrame)
}
