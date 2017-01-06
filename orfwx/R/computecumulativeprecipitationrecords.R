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
    
    originalFrame <- orfwx::computeExtraDateVariables(originalFrame) %>% 
      dplyr::select(-DayOfYear) %>% 
      dplyr::filter(Month == ccprMonth)
    recordsFrame <- dplyr::group_by(originalFrame, Month, DayOfMonth) %>% 
      dplyr::summarise(maxMTDPrecip = max(MTDPrecip),
                       minMTDPrecip = min(MTDPrecip)) %>% 
      as.data.frame()
    
    # Determine the most recent year for the records.
    yearsFrame <- dplyr::select(recordsFrame, Month, DayOfMonth)
    # CURRENTLY: yearsFrame only contains the Month and DayOfMonth for the
    #            appropriate month.
    
    return(recordsFrame)
}
