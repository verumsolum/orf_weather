#' Historical weather observations from Norfolk weather bureau
#' 
#' A dataset containing observations of weather from 1874 through 1945 from 
#' Norfolk, VA. After that, weather observations were taken at the airport
#' are used by this package.
#' 
#' @format A data frame with 33,510 observations of 6 variables.
#' \describe{
#'   \item{Date}{the date of the observation}
#'   \item{MaxTemperature}{(integer) the high temperature (in °F)}
#'   \item{MinTemperature}{(integer) the low temperature (in °F)}
#'   \item{AvgTemperature}{(double) the average temperature (in °F)}
#'   \item{CsvPrecipitation}{(character) the day's precipitation (in inches),
#'     as expressed in the original comma separated value (CSV) file.
#'     \strong{NOTE:} Either the letter `T` (for trace) or a number,
#'     expressed to the hundredth of an inch}
#'   \item{CsvSnowfall}{(character) the day's snowfall (in inches),
#'     as expressed in the original comma separated value (CSV) file.
#'     \strong{NOTE:} Either the letter `T` (for trace) or a number,
#'     expressed to the tenth of an inch}
#' }
#' @source \url{http://climodtest.nrcc.cornell.edu/}
"earlyDowntownData"
