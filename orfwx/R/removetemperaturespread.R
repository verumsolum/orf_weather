#' Remove temperature spread variable from a data frame
#' 
#' `removeTemperatureSpread` removes from a data frame the
#' `TemperatureSpread` variable which was added by 
#' [computeTemperatureSpread()].
#' 
#' This function may be used to keep the `TemperatureSpread` variable
#' from cluttering up display, if it is no longer needed.
#' 
#' @param originalFrame The data frame from which the `TemperatureSpread` 
#'   variable is removed.
#' @return Returns a data frame.
#' @examples
#' removeTemperatureSpread(computeTemperatureSpread(airportData))
#' @export
removeTemperatureSpread <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -TemperatureSpread)
  return(originalFrame)
}
