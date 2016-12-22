#' Remove extra date variables from a data frame
#' 
#' \code{removeWithVariables} removes from a data frame the
#' \code{WithPrecipitation} and \code{WithSnowfall} variables.
#' 
#' This function may be used to keep them from cluttering up display, if these
#' variables are no longer needed.
#' 
#' @param originalFrame The data frame from which the date variables are 
#'   removed.
#' @return Returns a data frame.
#' @examples
#' \dontrun{removeWithVariables(bothStations)}
#' @export
removeWithVariables <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -WithPrecipitation, -WithSnowfall)
  return(originalFrame)
}
