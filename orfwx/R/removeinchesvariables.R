#' Remove inches variables from a data frame
#' 
#' \code{removeInchesVariables} removes from a data frame the
#' \code{PrecipitationInches} and  \code{SnowfallInches} variables.
#' 
#' This function may be used to keep these variables from cluttering up
#' display, if they are no longer needed.
#' 
#' @param originalFrame The data frame from which the inches variables are 
#'   removed.
#' @return Returns a data frame.
#' @examples
#' removeInchesVariables(convertCsvToNumericAndLogical(airportData))
#' @export
removeInchesVariables <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame,
                                 -PrecipitationInches, -SnowfallInches)
  return(originalFrame)
}
