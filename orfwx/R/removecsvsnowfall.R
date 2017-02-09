#' Remove original snowfall variable from a data frame
#' 
#' `removeCsvSnowfall` removes from a data frame the
#' `CsvSnowfall` variable.
#' 
#' This function may be used to keep this information from cluttering up 
#' display, if the `CsvSnowfall` is no longer needed.
#' 
#' @param originalFrame The data frame from which the `CsvSnowfall`
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
