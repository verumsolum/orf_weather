#' Remove snowfall amount variable from a data frame
#' 
#' \code{removeSnowfallInches} removes from a data frame the
#' \code{SnowfallInches} variable.
#' 
#' This function may be used to keep the \code{SnowfallInches} variable from
#' cluttering up display, if it is no longer needed.
#' 
#' @param originalFrame The data frame from which the \code{SnowfallInches}
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
