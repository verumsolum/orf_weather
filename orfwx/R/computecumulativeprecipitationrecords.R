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
computeCumulativePrecipitationRecords <- 
  function(originalFrame = orfwx::computeCumulativePrecipitation() {
    originalFrame <- orfwx::computeExtraDateVariables(originalFrame) %>% 
      dplyr::select(-DayOfYear) %>% 
      dplyr::filter(Month == 1) %>% 
      dplyr::group_by(Month, DayOfMonth) %>% 
      dplyr::summarise(maxMTDPrecip = max(MTDPrecip),
                       minMTDPrecip = min(MTDPrecip)) %>% 
      as.data.frame()
}
