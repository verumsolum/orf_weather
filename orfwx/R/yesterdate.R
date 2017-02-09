#' Yesterday's date
#' 
#' `yesterdate` returns the previous day's date.
#' 
#' This is a convenience function since many times, functions are run for the
#' previous day's information.
#' 
#' @return Returns a date
#' @examples
#' yesterdate()
#' @export
yesterdate <- function(){
  Sys.Date() - 1
}
