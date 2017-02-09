#' Pad a number with a zero to create a two-character string (if single digit).
#' 
#' `padSingleDigitInteger` returns a two-character string, padding a
#' single-digit integer with a leading zero, if required.
#' 
#' This function converts `theInteger` into an integer and
#' returns that integer if between 10 and 99 (inclusive); otherwise, 
#' it adds a leading zero, to create a two-character string.
#' 
#' Errors will be provided for negative integers and integers with
#' more than two digits.
#' 
#' @param theInteger Any integer between 0 and 99 (inclusive).
#' @return Returns a two-character string.
#' @examples
#' padSingleDigitInteger(20)  # "20"
#' padSingleDigitInteger(9)  # "09"
#' padSingleDigitInteger(0)  # "00"
#' @export
padSingleDigitInteger <- function(theInteger) {
  # Fail if given invalid inputs
  if(as.integer(theInteger) >= 100) stop("theInteger has more than 2 digits")
  if(as.integer(theInteger) < 0) stop("theInteger is a negative integer")
  
  # If theInteger is valid, return it as a string
  theStringVersion <- as.character(abs(as.integer(theInteger)))
  if(as.integer(theInteger) >= 10 ) {
    return(theStringVersion)
  } else {
    theStringVersion <- paste0("0", theStringVersion)
    return(theStringVersion)
  }
}
