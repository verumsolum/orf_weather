#' Remove precipitation amount variable from a data frame
#' 
#' `removePrecipitationInches` removes from a data frame the
#' `PrecipitationInches` variable.
#' 
#' This function may be used to keep the `PrecipitationInches` variable
#' from cluttering up display, if it is no longer needed.
#' 
#' @param originalFrame The data frame from which the
#'   `PrecipitationInches` variable is removed.
#' @return Returns a data frame.
#' @examples
#' removePrecipitationInches(convertCsvToNumericAndLogical(airportData))
#' @export
removePrecipitationInches <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -PrecipitationInches)
  return(originalFrame)
}
