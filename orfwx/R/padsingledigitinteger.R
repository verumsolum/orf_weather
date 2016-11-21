#' Pad a number with a zero to create a two-character string (if single digit).
#' 
#' \code{padSingleDigitInteger} returns a two-character string, padding a
#' single-digit integer with a leading zero, if required.
#' 
#' This function currently converts \code{theInteger} into an integer and
#' returns that integer if greater than 10; otherwise, it adds a leading
#' zero, intended to create a two-character string.
#' 
#' The input is not currently checked for all necessary correctness.
#' For sensible results, \code{TheInteger} should be a positive integer,
#' less than or equal to 99.
#' 
#' @param theInteger Any integer.
#' @return Intended to return a two-character string
#' @examples
#' padSingleDigitInteger(20)  # 20
#' padSingleDigitInteger(9)  # "09"
#' padSingleDigitInteger(0)  # "00"
#' @export
padSingleDigitInteger <- function(theInteger) {
  if(as.numeric(theInteger) >= 10 ) return(abs(as.integer(theInteger)))  # What is good style for if in R
  paste0("0", as.character(abs(as.integer(theInteger))))
}
