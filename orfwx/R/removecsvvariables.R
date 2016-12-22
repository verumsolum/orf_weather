#' Remove extra date variables from a data frame
#' 
#' \code{removeCsvVariables} removes from a data frame the
#' \code{removeCsvPrecipitation} and \code{CsvSnowfall} variables.
#' 
#' This function may be used to keep them from cluttering up display, if the
#' those variables are no longer needed.
#' 
#' @param originalFrame The data frame from which the date variables are 
#'   removed.
#' @return Returns a data frame.
#' @examples
#' \dontrun{removeCsvVariables(bothStations)}
#' @export
removeCsvVariables <- function(originalFrame){
  originalFrame <- dplyr::select(originalFrame, 
                                 -CsvPrecipitation, -CsvSnowfall)
  return(originalFrame)
}
