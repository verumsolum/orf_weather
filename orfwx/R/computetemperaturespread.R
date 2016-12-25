#' Add variable for temperature spread to a data frame
#' 
#' \code{computeTemperatureSpread} appends a variable to the data frame with
#' the difference between the day's high and low temperatures.
#' 
#' The difference between \code{MaxTemperature} and \code{MinTemperature} is
#' computed and added to a \code{TemperatureSpread} variable in the data frame.
#' 
#' This will stop with an error if those columns are not present in
#' \code{originalFrame}.
#' 
#' @param originalFrame The data frame to which the \code{TemperatureSpread} 
#'   variable is appended.
#' @return Returns a data frame.
#' @examples
#' computeTemperatureSpread(airportData)
#' @export
computeTemperatureSpread <- function(originalFrame){
  originalFrame <- dplyr::mutate(
    originalFrame,
    TemperatureSpread = as.integer(MaxTemperature - MinTemperature)
  )
  return(originalFrame)
}
