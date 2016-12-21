#' Remove extra date variables from a data frame
#' 
#' \code{removeTemperatureSpread} removes from a data frame the
#' \code{TemperatureSpread} variable which was added by 
#' \code{\link{computeTemperatureSpread}}.
#' 
#' This function may be used to keep them from cluttering up display, if the
#' \code{TemperatureSpread} is no longer needed.
#' 
#' @param originalFrame The data frame from which the date variables are 
#'   removed.
#' @return Returns a data frame.
#' @examples
#' \dontrun{removeTemperatureSpread(computeTemperatureSpread(bothStations))}
#' @export
removeTemperatureSpread <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -TemperatureSpread)
  return(originalFrame)
}
