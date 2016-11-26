#' Historical weather observations from Norfolk, Virginia
#' 
#' A dataset containing observations of weather since 1874 from Norfolk, VA.
#' Since 1946, those observations are taken at ORF, Norfolk International
#' Airport. Prior to that, they were taken at the Weather Bureau offices in
#' the city.
#' 
#' @format A data frame with 52,186 observations of 12 variables.
#' \describe{
#'   \item{Date}{the date of the observation}
#'   \item{MaxTemperature}{the high temperature (in °F)}
#'   \item{MinTemperature}{the low temperature (in °F)}
#'   \item{AvgTemperature}{the average temperature (in °F)}
#'   \item{Precipitation}{the day's precipitation (in inches)}
#'   \item{Snowfall}{the day's snowfall (in inches)}
#'   \item{Year}{the year of the observation (1874-2016)}
#'   \item{Month}{the month of the observation (1-12)}
#'   \item{DayofMonth}{the day of the observation (1-31)}
#'   \item{DayofYear}{the day of the observation within the year (1-366)}
#'   \item{leapYearAwareDayOfYear}{\code{DayofYear} altered to ensure that the
#'     number uniquely identifies the date whether the \code{Year} is a leap
#'     year or not}
#'   \item{temperatureSpread}{the difference between the day's high and low
#'     temperatures (in °F)}
#' }
"mutatedBothStations"
