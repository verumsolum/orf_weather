#' Find the weather for a give day each year.
#' 
#' `dayEachYear` takes a data frame with weather information and returns only
#' the weather for one particular day of each year.
#' 
#' Details section to be written.
#' 
#' @param wxUniverse The data frame with the weather information we will be 
#'   taking the data from.
#' @param deyMonth An integer representing the month of the year (1=January, 
#'   12=December) for which the date we are interested in.
#' @param deyDayOfMonth An integer representing the day of the month (1-31) for
#'   the date we are interested in.
#' @return A data frame is returned.
#' @examples
#' dayEachYear(deyMonth = 2, deyDayOfMonth = 15)  # Weather for February 15th
#' @export
dayEachYear <- function(wxUniverse = orfwx::allData(), 
                        deyMonth, 
                        deyDayOfMonth) {
  # Ensure sane values for deyMonth and deyDayOfMonth
  deyMonth <- as.integer(deyMonth)
  deyDayOfMonth <- as.integer(deyDayOfMonth)
  
  deyDf <- wxUniverse %>%
    orfwx::computeExtraDateVariables() %>%
    dplyr::filter(Month = deyMonth, DayOfMonth = deyDayOfMonth)
  deyDf
}
