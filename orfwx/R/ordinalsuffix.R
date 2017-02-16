#' Add an ordinal suffix to an integer
#' 
#' `ordinalSuffix` returns the integer provided to it as a string, with the
#' ordinal suffix (_st_, _nd_, _rd_, or _th_) appended.
#' 
#' This function's workflow:
#' 
#' 1. Is `osInteger` a positive integer? If not, a warning is issued and this
#'    function returns `osInteger` unchanged.
#' 2. Determine what the proper suffix should be:
#'    1. If the _tens_ digit is a 1 (e.g., 10 through 19, 110 through 19, etc.),
#'       the suffix is `th`.
#'    2. In all other cases, look to the result of `osInteger` mod 10:
#'       * If 1, suffix is `st`,
#'       * If 2, suffix is `nd``,
#'       * If 3, suffix is `rd``, and
#'       * In all other cases, suffix is `th`.
#' 3. Paste together `osInteger` with the suffix and return this as a string.
#' 
#' @param osInteger The number to convert.
#' @return Returns a string.
#' @examples
#' ordinalSuffix(1)  # Returns "1st"
#' ordinalSuffix(2)  # Returns "2nd"
#' ordinalSuffix(3)  # Returns "3rd"
#' ordinalSuffix(4)  # Returns "4th"
#' ordinalSuffix(11)  # Returns "11th"
ordinalSuffix <- function(osInteger) {
  # Sanity check
  osInteger <- as.integer(osInteger)
  
  # Initialize
  oSuffix <- character()
  
  if(osInteger < 1) {
    warning(paste("ordinalSuffix requires positive integer. Returning",
                  paste0('"', osInteger, '"'),
                  "unchanged."))
  } else {
    osFinalDigit <- osInteger %% 10
    if(((osInteger %/% 10) %% 10) == 1 ) {
      # For numbers 10-19, 110-119, 210-219, etc.
      oSuffix <- "th"
    } else if(osFinalDigit == 1) {
      oSuffix <- "st"
    } else if(osFinalDigit == 2) {
      oSuffix <- "nd"
    } else if(osFinalDigit == 3) {
      oSuffix <- "rd"
    } else {
      oSuffix <- "th"
    }
  }
  paste0(osInteger, oSuffix)
}
