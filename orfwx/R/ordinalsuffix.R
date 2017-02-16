#' Add an ordinal suffix to an integer
#' 
#' `ordinalSuffix` returns the integer provided to it as a string, with the
#' ordinal suffix (_st_, _nd_, _rd_, or _th_) appended.
#' 
#' This function determines that the year in question is:
#' * not NULL
#' * not earlier than 1724 (the year the Fahrenheit scale was developed)
#' * not later than the current year
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
  osReason <- character()
  
  if(osInteger < 1) {
    warning(paste("ordinalSuffix requires positive integer. Returning",
                  paste0('"', osInteger, '"'),
                  "unchanged."))
    osReason <- "Not a positive integer"
  } else {
    osFinalDigit <- osInteger %% 10
    if(((osInteger %/% 10) %% 10) == 1 ) {
      # For numbers 10-19, 110-119, 210-219, etc.
      oSuffix <- "th"
      osReason <- "Teens"
    } else if(osFinalDigit == 1) {
      oSuffix <- "st"
      osReason <- "Ones"
    } else if(osFinalDigit == 2) {
      oSuffix <- "nd"
      osReason <- "Twos"
    } else if(osFinalDigit == 3) {
      oSuffix <- "rd"
      osReason <- "Threes"
    } else {
      oSuffix <- "th"
      osReason <- "Default"
    }
  }
  paste0(osInteger, oSuffix)
}
