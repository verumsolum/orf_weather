#' Calculate consecutive days of precipitation
#' 
#' \code{computeConsecutivePrecipVariables} appends 
#' \code{consecutivePrecipitation} and \code{consecutiveSnowfall} variables, 
#' each containing an integer representing the number of consecutive days with
#' recorded precipitation and snowfall, respectively.
#' 
#' This function sorts \code{originalFrame} by date, and then the two 
#' variables (\code{consecutivePrecipitation} and \code{consecutiveSnowfall}) 
#' are initialized with a value of 0. Then, a for loop is used which leaves 
#' that initialized value alone if \code{WithPrecipitation} (or 
#' \code{WithSnowfall}) is \code{FALSE} or \code{NA}. If the 
#' \dQuote{With* variable} is \code{TRUE}, the value of the previous day's
#' \dQuote{consecutive* variable} is taken and incremented by 1.
#' 
#' This function assumes that \code{originalFrame} contains the precipitation
#' variables (which are usually created by 
#' \code{\link{convertCsvToNumericAndLogical}}) and assumes that 
#' \code{originalFrame} is sorted from earliest to most recent. If either of
#' these is not the case, this function will fail or return data which are
#' incorrect.
#' 
#' @param originalFrame The data frame to which the 
#'   \code{consecutivePrecipitation} and \code{consecutiveSnowfall} variables 
#'   will be appended.
#' @return Returns a data frame.
#' @examples
#' computeConsecutivePrecipVariables(convertCsvToNumericAndLogical(
#'                                     computeExtraDateVariables(airportData)))
#' @export
computeConsecutivePrecipVariables <- function(originalFrame) {
  # Ensure originalFrame is sorted by date.
  originalFrame <- dplyr::arrange(originalFrame, Date)
  
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
