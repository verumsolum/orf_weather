#' Remove extra date variables from a data frame
#' 
#' \code{removeWithPrecipitation} removes from a data frame the
#' \code{WithPrecipitation} variable.
#' 
#' This function may be used to keep them from cluttering up display, if the
#' \code{WithPrecipitation} is no longer needed.
#' 
#' @param originalFrame The data frame from which the date variables are 
#'   removed.
#' @return Returns a data frame.
#' @examples
#' \dontrun{removeWithPrecipitation(bothStations)}
#' @export
removeWithPrecipitation <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -WithPrecipitation)
  return(originalFrame)
}
