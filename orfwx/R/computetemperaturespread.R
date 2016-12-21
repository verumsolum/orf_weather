#' Add variable for temperature spread to a data frame
#' 
#' \code{computeTemperatureSpread} appends extra date variables to data frame.
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
#' \dontrun{computeTemperatureSpread(bothStations)}
#' @export
computeTemperatureSpread <- function(originalFrame){
  originalFrame <- dplyr::mutate(
    originalFrame,
    TemperatureSpread = as.integer(MaxTemperature - MinTemperature)
  )
  return(originalFrame)
}
