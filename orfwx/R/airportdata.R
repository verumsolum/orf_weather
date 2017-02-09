#' Historical weather observations from Norfolk International Airport
#' 
#' A dataset containing observations of weather since 1946 from Norfolk 
#' International Airport in Norfolk, VA. Prior to that, the city's weather 
#' observations were taken at the Weather Bureau offices in the city.
#' 
#' @format A data frame with 25,916 observations of 6 variables.
#' \describe{
#'   \item{Date}{the date of the observation}
#'   \item{MaxTemperature}{(integer) the high temperature (in °F)}
#'   \item{MinTemperature}{(integer) the low temperature (in °F)}
#'   \item{AvgTemperature}{(double) the average temperature (in °F)}
#'   \item{CsvPrecipitation}{(character) the day's precipitation (in inches),
#'     as expressed in the original comma separated value (CSV) file.
#'     **NOTE:** Either the letter `T` (for trace) or a number,
#'     expressed to the hundredth of an inch}
#'   \item{CsvSnowfall}{(character) the day's snowfall (in inches),
#'     as expressed in the original comma separated value (CSV) file.
#'     **NOTE:** Either the letter `T` (for trace) or a number,
#'     expressed to the tenth of an inch}
#' }
#' @source \url{http://climodtest.nrcc.cornell.edu/}
"airportData"
