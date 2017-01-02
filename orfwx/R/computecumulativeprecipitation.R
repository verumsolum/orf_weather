#' Compute cumulative precipitation variables
#' 
#' \code{computeCumulativePrecipitation} returns a data frame with
#' month-to-date and year-to-date variables for precipitation.
#' 
#' Details section to be written
#' 
#' @return Returns a data frame.
#' @examples
#' \dontrun{computeCumulativePrecipitation()}
#' @export
computeCumulativePrecipitation <- function(originalFrame = allData(),
                                           daysWeather = NULL) {
  # Give ccpDf the data to be used.
  if(is.null(daysWeather)) {
    ccpDf <- originalFrame
  } else {
    ccpDf <- combineDataFrames(originalFrame, daysWeather)
  }
  
  # Create MTD and YTD precipitation variables
  ccpDf <- ccpDf %>%
    convertCsvToNumericAndLogical() %>% 
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
    dplyr::mutate(YTDPrecip = cumsum(PrecipitationInches))
}
