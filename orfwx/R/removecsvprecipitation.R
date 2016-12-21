#' Remove extra date variables from a data frame
#' 
#' \code{removeCsvPrecipitation} removes from a data frame the
#' \code{CsvPrecipitation} variable.
#' 
#' This function may be used to keep them from cluttering up display, if the
#' \code{CsvPrecipitation} is no longer needed.
#' 
#' @param originalFrame The data frame from which the date variables are 
#'   removed.
#' @return Returns a data frame.
#' @examples
#' \dontrun{removeCsvPrecipitation(bothStations)}
#' @export
removeCsvPrecipitation <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -CsvPrecipitation)
  return(originalFrame)
}
