#' Remove precipitation amount variable from a data frame
#' 
#' \code{removePrecipitationInches} removes from a data frame the
#' \code{PrecipitationInches} variable.
#' 
#' This function may be used to keep the \code{PrecipitationInches} variable
#' from cluttering up display, if it is no longer needed.
#' 
#' @param originalFrame The data frame from which the
#'   \code{PrecipitationInches} variable is removed.
#' @return Returns a data frame.
#' @examples
#' removePrecipitationInches(convertCsvToNumericAndLogical(airportData))
#' @export
removePrecipitationInches <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -PrecipitationInches)
  return(originalFrame)
}
