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
  # Set up variables for consecutive days...
  originalFrame[["consecutivePrecipitation"]] <- 0
  originalFrame[["consecutiveSnowfall"]] <- 0

  for(i in 1:nrow(originalFrame)) {
    # For each row, first calculate for precipitation.
    if(!is.na(originalFrame[["WithPrecipitation"]][i]) & 
       originalFrame[["WithPrecipitation"]][i] == TRUE) {
      # If WithPrecipitation == TRUE, then in most cases...
      if(i != 1) {
        originalFrame[["consecutivePrecipitation"]][i] = 
          originalFrame[["consecutivePrecipitation"]][i - 1] + 1
      } else {
        originalFrame[["consecutivePrecipitation"]][i] = 1
      }
    }
    
    # ...then calculate for snowfall.
    if(!is.na(originalFrame[["WithSnowfall"]][i]) &
       originalFrame[["WithSnowfall"]][i] == TRUE) {
      # If WithSnowfall == TRUE, then in most cases...
      if(i != 1) {
        originalFrame[["consecutiveSnowfall"]][i] =
          originalFrame[["consecutiveSnowfall"]][i - 1] + 1
      } else {
        originalFrame[["consecutiveSnowfall"]][i] = 1
      }
    }
  }
  return(originalFrame)
}
