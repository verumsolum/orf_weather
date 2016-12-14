#' Historical weather observations from Norfolk, Virginia
#' 
#' A dataset containing observations of weather since 1874 from Norfolk, VA.
#' Since 1946, those observations are taken at ORF, Norfolk International
#' Airport. Prior to that, they were taken at the Weather Bureau offices in
#' the city.
#' 
#' @format A data frame with 52,199 observations of 12 variables.
#' \describe{
#'   \item{Date}{the date of the observation}
#'   \item{MaxTemperature}{(integer) the high temperature (in °F)}
#'   \item{MinTemperature}{(integer) the low temperature (in °F)}
#'   \item{AvgTemperature}{(double) the average temperature (in °F)}
#'   \item{Year}{(integer) the year of the observation (1874-2016)}
#'   \item{Month}{(integer) the month of the observation (1-12)}
#'   \item{DayOfMonth}{(integer) the day of the observation (1-31)}
#'   \item{DayOfYear}{(integer) the day of the observation within the year 
#'     (1-366)}
#'   \item{leapYearAwareDayOfYear}{(integer) \code{DayofYear} altered to 
#'     ensure that the number uniquely identifies the date whether the 
#'     \code{Year} is a leap year or not (1-366)}
#'   \item{temperatureSpread}{(integer) the difference between the day's high 
#'     and low temperatures (in °F)}
#'   \item{CsvPrecipitation}{(character) the day's precipitation (in inches),
#'     as expressed in the original comma separated value (CSV) file.
#'     \strong{NOTE:} Either the letter \code{T} (for trace) or a number,
#'     expressed to the hundredth of an inch}
#'   \item{PrecipitationInches}{(double) the day's precipitation (expressed to
#'     the hundredth of an inch)}
#'   \item{WithPrecipitation}{(logical) whether or not precipitation fell on 
#'     this day}
#'   \item{CsvSnowfall}{(character) the day's snowfall (in inches),
#'     as expressed in the original comma separated value (CSV) file.
#'     \strong{NOTE:} Either the letter \code{T} (for trace) or a number,
#'     expressed to the tenth of an inch}
#'   \item{SnowfallInches}{(double) the day's snowfall (expressed to the
#'     tenth of an inch)}
#'   \item{WithSnowfall}{(logical) whether or not snow fell on this day}
#' }
#' @source \url{http://climodtest.nrcc.cornell.edu/}
"mutatedBothStations"
