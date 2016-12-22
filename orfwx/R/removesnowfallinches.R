#' Remove extra date variables from a data frame
#' 
#' \code{removeSnowfallInches} removes from a data frame the
#' \code{SnowfallInches} variable.
#' 
#' This function may be used to keep them from cluttering up display, if the
#' \code{SnowfallInches} is no longer needed.
#' 
#' @param originalFrame The data frame from which the date variables are 
#'   removed.
#' @return Returns a data frame.
#' @examples
#' \dontrun{removeSnowfallInches(bothStations)}
#' @export
removeSnowfallInches <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -SnowfallInches)
  return(originalFrame)
}
