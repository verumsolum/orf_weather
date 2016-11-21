#' Determining whether or not this is a leap year.
#' 
#' \code{is.leapYear} returns \code{TRUE} or \code{FALSE}, depending on
#' whether or not the year passed to it is a leap year or not.
#' 
#' This function determines that the year in question is:
#' \itemize{
#'   \item evenly divisible by 4, and
#'   \item not evenly divisible by 100, or
#'   \item \emph{(ignoring the previous conditions)} evenly divisible by 400
#' }
#' 
#' @param year An integer value for the year in question.
#' @return Returns a logical value (\code{TRUE} or \code{FALSE}).
#' @examples
#' is.leapYear(2016)  # TRUE (divisible by 4)
#' is.leapYear(2015)  # FALSE (not divisible by 4)
#' is.leapYear(1900)  # FALSE (divisible by 100)
#' is.leapYear(2000)  # TRUE (divisible by 400)
#' @export
is.leapYear=function(year){
  #http://en.wikipedia.org/wiki/Leap_year
  return(((year %% 4 == 0) & (year %% 100 != 0)) | (year %% 400 == 0))
}
