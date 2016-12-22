#' Remove extra date variables from a data frame
#' 
#' \code{removeInchesVariables} removes from a data frame the
#' \code{PrecipitationInches} and  \code{SnowfallInches} variables.
#' 
#' This function may be used to keep them from cluttering up display, if these
#' variables are no longer needed.
#' 
#' @param originalFrame The data frame from which the date variables are 
#'   removed.
#' @return Returns a data frame.
#' @examples
#' \dontrun{removeInchesVariables(bothStations)}
#' @export
removeInchesVariables <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame,
                                 -PrecipitationInches, -SnowfallInches)
  return(originalFrame)
}
