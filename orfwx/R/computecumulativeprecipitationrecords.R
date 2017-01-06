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
  function(originalFrame = orfwx::computeCumulativePrecipitation(),
           ccprMonth = format(orfwx::yesterdate(), "%m")) {
    # Ensure ccprMonth is an integer between 1 and 12, inclusive.
    ccprMonth <- as.integer(ccprMonth)
    if(ccprMonth < 1 | ccprMonth > 12) {
      warning("Invalid month passed to computeCumulativePrecipitationRecords.")
      # Use yesterday's month
      ccprMonth <- as.integer(format(orfwx::yesterdate(), "%m"))
    }
    
    recordsFrame <- orfwx::computeExtraDateVariables(originalFrame) %>% 
      dplyr::select(-DayOfYear) %>% 
      dplyr::filter(Month == ccprMonth) %>% 
      dplyr::group_by(Month, DayOfMonth) %>% 
      dplyr::summarise(maxMTDPrecip = max(MTDPrecip),
                       minMTDPrecip = min(MTDPrecip)) %>% 
      as.data.frame()
    return(recordsFrame)
}
