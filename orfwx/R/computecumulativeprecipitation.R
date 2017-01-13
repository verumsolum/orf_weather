#' Compute cumulative precipitation variables
#' 
#' \code{computeCumulativePrecipitation} returns a data frame with
#' month-to-date and year-to-date variables for precipitation.
#' 
#' Details section to be written
#' 
#' @param originalFrame (optional) The data frame to which the \code{MTDPrecip} and 
#'   \code{YTDPrecip} variables are appended. Defaults to \code{allData()}.
#' @param daysWeather (optional) The weather for a date not yet included in
#'   the \code{originalFrame} data frame, usually passed by the
#'   \code{singleDaysWeather} function.
#' @return Returns a data frame.
#' @examples
#' \dontrun{computeCumulativePrecipitation()}
#' @export
#' @importFrom dplyr "%>%"
computeCumulativePrecipitation <- function(originalFrame = orfwx::allData(),
                                           daysWeather = NULL) {
  # Give ccpDf the data to be used.
  if(is.null(daysWeather)) {
    ccpDf <- originalFrame
  } else {
    ccpDf <- combineDataFrames(originalFrame, daysWeather)
  }
  
  # Create MTD and YTD precipitation variables
  ccpDf <- ccpDf %>%
    convertCsvToNumericAndLogical()
  
  # To avoid `NA` values in cumulative totals, change PrecipitationInches to 0
  # (while saving a copy of the original)
  ccpOriginalPI <- ccpDf[["PrecipitationInches"]]
  ccpDf[["PrecipitationInches"]][is.na(ccpDf[["PrecipitationInches"]])] <- 0

  ccpDf <- ccpDf %>%  
    computeExtraDateVariables() %>% 
    dplyr::select(Date,
                  CsvPrecipitation,
                  PrecipitationInches,
                  WithPrecipitation,
                  Year,
                  Month,
                  DayOfMonth) %>% 
    dplyr::group_by(Year, Month) %>% 
    dplyr::mutate(MTDPrecip = cumsum(PrecipitationInches)) %>% 
    dplyr::group_by(Year) %>% 
    dplyr::mutate(YTDPrecip = cumsum(PrecipitationInches)) %>%
    dplyr::ungroup() %>%
    dplyr::select(-Month, -DayOfMonth)
  
  # Restore original values for PrecipitationInches
  ccpDf[["PrecipitationInches"]] <- ccpOriginalPI
  
  return(ccpDf)
}
