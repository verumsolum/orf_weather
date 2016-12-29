#' Calculate consecutive days of precipitation
#' 
#' \code{computeConsecutivePrecipVariables} appends a 
#' \code{consecutivePrecipitation} variable containing an integer.
#' 
#' Details section to be added.
#' 
#' @param originalFrame The data frame to which the 
#'   \code{consecutivePrecipitation} variable is appended.
#' @return Returns a data frame.
#' @examples
#' computeConsecutivePrecipVariables(convertCsvToNumericAndLogical(computeExtraDateVariables(airportData)))
#' @export
computeConsecutivePrecipVariables <- function(originalFrame) {
  originalFrame[["consecutivePrecipitation"]] <- 0
  for(i in 1:nrow(originalFrame)) {
    if(!is.na(originalFrame[["WithPrecipitation"]][i]) & originalFrame[["WithPrecipitation"]][i] == TRUE) {
      # If WithPrecipitation == TRUE, then in most cases...
      if(i != 1) {
        originalFrame[["consecutivePrecipitation"]][i] = originalFrame[["consecutivePrecipitation"]][i - 1] + 1
      } else {
        originalFrame[["consecutivePrecipitation"]][i] = 1
      }
    }
  }
  return(originalFrame)
}
