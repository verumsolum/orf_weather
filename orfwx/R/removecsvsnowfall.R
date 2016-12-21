#' Remove extra date variables from a data frame
#' 
#' \code{removeCsvSnowfall} removes from a data frame the
#' \code{CsvSnowfall} variable.
#' 
#' This function may be used to keep them from cluttering up display, if the
#' \code{CsvSnowfall} is no longer needed.
#' 
#' @param originalFrame The data frame from which the date variables are 
#'   removed.
#' @return Returns a data frame.
#' @examples
#' \dontrun{removeCsvSnowfall(bothStations)}
#' @export
removeCsvSnowfall <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -CsvSnowfall)
  return(originalFrame)
}
