#' Remove extra date variables from a data frame
#' 
#' \code{removeWithSnowfall} removes from a data frame the
#' \code{WithSnowfall} variable.
#' 
#' This function may be used to keep them from cluttering up display, if the
#' \code{WithSnowfall} is no longer needed.
#' 
#' @param originalFrame The data frame from which the date variables are 
#'   removed.
#' @return Returns a data frame.
#' @examples
#' \dontrun{removeWithSnowfall(bothStations)}
#' @export
removeWithSnowfall <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -WithSnowfall)
  return(originalFrame)
}
