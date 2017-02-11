#' Calculate consecutive days of precipitation
#' 
#' `computeConsecutivePrecipVariables` appends 
#' `consecutivePrecipitation` and `consecutiveSnowfall` variables, 
#' each containing an integer representing the number of consecutive days with
#' recorded precipitation and snowfall, respectively.
#' 
#' This function sorts `originalFrame` by date, and then the two 
#' variables (`consecutivePrecipitation` and `consecutiveSnowfall`) 
#' are initialized with a value of 0. Then, a for loop is used which leaves 
#' that initialized value alone if `WithPrecipitation` (or 
#' `WithSnowfall`) is `FALSE` or `NA`. If the 
#' \dQuote{With* variable} is `TRUE`, the value of the previous day's
#' \dQuote{consecutive* variable} is taken and incremented by 1.
#' 
#' This function assumes that `originalFrame` contains the precipitation
#' variables (which are usually created by 
#' [convertCsvToNumericAndLogical()]) and assumes that 
#' `originalFrame` is sorted from earliest to most recent. If either of
#' these is not the case, this function will fail or return data which are
#' incorrect.
#' 
#' This function has been extended to also create 
#' `consecutiveMeasurablePrecipitation` (counting days with precipitation ≥ 
#' 0.01").
#' 
#' @param originalFrame The data frame to which the 
#'   `consecutivePrecipitation` and `consecutiveSnowfall` variables 
#'   will be appended.
#' @return Returns a data frame.
#' @examples
#' computeConsecutivePrecipVariables(convertCsvToNumericAndLogical(
#'                                     airportData))
#' @export
computeConsecutivePrecipVariables <- function(originalFrame) {
  # Ensure originalFrame is sorted by date.
  originalFrame <- dplyr::arrange(originalFrame, Date)
  
  # Set up variables for consecutive days...
  originalFrame[["consecutivePrecipitation"]] <- 0
  originalFrame[["consecutiveSnowfall"]] <- 0
  originalFrame[["consecutiveMeasurablePrecipitation"]] <- 0

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
    
    # Next let's work with measurable precip.
    if(!is.na(originalFrame[["PrecipitationInches"]][i]) & 
       originalFrame[["PrecipitationInches"]][i] > 0) {
      # If PrecipitationInches > 0, then in most cases...
      if(i != 1) {
        originalFrame[["consecutiveMeasurablePrecipitation"]][i] = 
          originalFrame[["consecutiveMeasurablePrecipitation"]][i - 1] + 1
      } else {
        originalFrame[["consecutiveMeasurablePrecipitation"]][i] = 1
      }
    }
  }
  return(originalFrame)
}
