#' Remove extra date variables from a data frame
#' 
#' \code{removePrecipitationInches} removes from a data frame the
#' \code{PrecipitationInches} variable.
#' 
#' This function may be used to keep them from cluttering up display, if the
#' \code{PrecipitationInches} is no longer needed.
#' 
#' @param originalFrame The data frame from which the date variables are 
#'   removed.
#' @return Returns a data frame.
#' @examples
#' \dontrun{removePrecipitationInches(bothStations)}
#' @export
removePrecipitationInches <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -PrecipitationInches)
  return(originalFrame)
}
