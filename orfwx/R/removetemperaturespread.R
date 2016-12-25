#' Remove temperature spread variable from a data frame
#' 
#' \code{removeTemperatureSpread} removes from a data frame the
#' \code{TemperatureSpread} variable which was added by 
#' \code{\link{computeTemperatureSpread}}.
#' 
#' This function may be used to keep the \code{TemperatureSpread} variable
#' from cluttering up display, if it is no longer needed.
#' 
#' @param originalFrame The data frame from which the \code{TemperatureSpread} 
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
