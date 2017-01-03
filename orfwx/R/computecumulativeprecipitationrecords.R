#' Compute cumulative precipitation variables
#' 
#' \code{computeCumulativePrecipitationRecords} returns a data frame with
#' the maximum and minimum values of \code{MTDPrecip}.
#' 
#' Details section to be written
#' 
#' @param originalFrame (optional) The data frame to which the \code{MTDPrecip} and 
#'   \code{YTDPrecip} variables are appended. Defaults to \code{allData()}.
#' @return Returns a data frame.
#' @examples
#' \dontrun{computeCumulativePrecipitation()}
#' @export
#' @importFrom dplyr "%>%"
computeCumulativePrecipitation <- function(originalFrame = 
                                             computeCumulativePrecipitation(allData())) {
  originalFrame <- computeExtraDateVariables(originalFrame) %>% 
    select(-DayOfYear) %>% 
    dplyr::filter(Month == 1) %>% 
    group_by(Month, DayOfMonth) %>% 
    summarise(maxMTDPrecip = max(MTDPrecip), 
              minMTDPrecip = min(MTDPrecip)) %>% 
    as.data.frame()
}
