#' Remove original snowfall variable from a data frame
#' 
#' \code{removeCsvSnowfall} removes from a data frame the
#' \code{CsvSnowfall} variable.
#' 
#' This function may be used to keep this information from cluttering up 
#' display, if the \code{CsvSnowfall} is no longer needed.
#' 
#' @param originalFrame The data frame from which the \code{CsvSnowfall}
#'   variable is removed.
#' @return Returns a data frame.
#' @examples
#' removeCsvSnowfall(bothStations)
#' @export
removeCsvSnowfall <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -CsvSnowfall)
  return(originalFrame)
}
