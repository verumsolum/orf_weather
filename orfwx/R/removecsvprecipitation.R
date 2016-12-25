#' Remove original precipitation variable from a data frame
#' 
#' \code{removeCsvPrecipitation} removes from a data frame the
#' \code{CsvPrecipitation} variable.
#' 
#' This function may be used to keep this information from cluttering up 
#' display, if the \code{CsvPrecipitation} is no longer needed.
#' 
#' @param originalFrame The data frame from which the \code{CsvPrecipitation}
#'   variable is removed.
#' @return Returns a data frame.
#' @examples
#' removeCsvPrecipitation(airportData)
#' @export
removeCsvPrecipitation <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -CsvPrecipitation)
  return(originalFrame)
}
