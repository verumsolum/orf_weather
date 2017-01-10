#' Normal weather from Norfolk, Virginia (1981-2010)
#' 
#' A dataset containing normal weather conditions for Norfolk, VA, calculated
#' from 1981 through 2010 at ORF, Norfolk International Airport.
#' 
#' @format A data frame with 365 observations of 7 variables.
#' \describe{
#'   \item{Month}{the month of the observation}
#'   \item{DayOfMonth}{the date of the observation}
#'   \item{MTDPrecip}{the normal month-to-date precipitation total (in inches)}
#'   \item{YTDPrecip}{the normal year-to-date precipitation total (in inches)}
#'   \item{MaxTemperature}{(integer) the high temperature (in °F)}
#'   \item{MinTemperature}{(integer) the low temperature (in °F)}
#'   \item{AvgTemperature}{(double) the average temperature (in °F)}
#' }
#' @source \url{http://climodtest.nrcc.cornell.edu/}
"airportNormals"
