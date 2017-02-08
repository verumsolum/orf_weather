#' Compute cumulative precipitation variables
#' 
#' \code{computeCumulativePrecipitationRecords} returns a data frame with
#' the maximum and minimum values of \code{MTDPrecip}.
#' 
#' Details section to be written
#' 
#' @param originalFrame (optional) The data frame to which the \code{MTDPrecip} 
#'   and \code{YTDPrecip} variables are appended. Defaults to \code{allData()}.
#' @param ccprMonth (optional) The month for which precipitation records are
#'   desired. Defaults to the current month (except on the 1st of the month,
#'   when it defaults to the previous month).
#' @param showYear (optional) Whether or not to show the current or most recent
#'   year's data for comparison (defaults to \code{FALSE}).
#' @param includeNormals (optional) Whether or not to show the 1981-2010 
#'   normals for comparison (defaults to \code{FALSE}).
#' @param showLeapDay (optional) Whether or not to show data for February 29th
#'   (defaults to \code{FALSE}, unless the current year is a leap year).
#' @param showLastCompleteMonth (optional) Whether to show data from the last
#'   complete month or whether to show the month in progress (defaults to
#'   \code{FALSE}).
#' @return Returns a data frame.
#' @examples
#' \dontrun{computeCumulativePrecipitationRecords()}
#' @export
#' @importFrom dplyr "%>%"
computeCumulativePrecipRecords <- 
  function(originalFrame = 
             orfwx::computeCumulativePrecipitation(),
           ccprMonth = format(orfwx::yesterdate(), "%m"),
           showYear = FALSE,
           includeNormals = FALSE,
           showLeapDay = 
             orfwx::is.leapYear(as.integer(format(orfwx::yesterdate(), 
                                                  "%Y"))),
           showLastCompleteMonth = FALSE) {
    # Ensure ccprMonth is an integer between 1 and 12, inclusive.
    ccprMonth <- as.integer(ccprMonth)
    if(ccprMonth < 1 | ccprMonth > 12) {
      warning("Invalid month passed to computeCumulativePrecipitationRecords.")
      # Use yesterday's month
      ccprMonth <- as.integer(format(orfwx::yesterdate(), "%m"))
    }
    
    # Set year to display, if desired
    if(showYear) {
      currentMonth <- as.integer(format(orfwx::yesterdate(), "%m"))
      currentYear <- as.integer(format(orfwx::yesterdate(), "%Y"))
      if(currentMonth < ccprMonth) {
        # If we haven't yet had the month to be displayed this calendar year,
        # then use last year.
        currentYear <- currentYear - 1
      } else if((currentMonth == ccprMonth) & showLastCompleteMonth) {
        # If we're talking about the current month and
        # showLastCompleteMonth is TRUE…
        nextDaysMonth <- as.integer(format(Sys.Date(), "%m"))
        if(nextDaysMonth == currentMonth) {
          # If today's month and yesterday's month are the same,
          # this is an incomplete month, so we should use last year.
          currentYear <- currentYear - 1
        }
      }
      yearColumnName <- as.character(currentYear)
    }
    
    originalFrame <- orfwx::computeExtraDateVariables(originalFrame) %>% 
      dplyr::select(-DayOfYear) %>% 
      dplyr::filter(Month == ccprMonth)
    recordsFrame <- originalFrame
    recordsFrame <- recordsFrame %>%
      dplyr::group_by(Month, DayOfMonth) %>% 
      dplyr::summarise(maxMTDPrecip = max(MTDPrecip),
                       minMTDPrecip = min(MTDPrecip),
                       maxYTDPrecip = max(YTDPrecip),
                       minYTDPrecip = min(YTDPrecip)) %>% 
      as.data.frame()
    
    # Determine the most recent year for the records.
    yearsFrame <- dplyr::select(recordsFrame, Month, DayOfMonth)
    
    # Initialize new variables within yearsFrame.
    yearsFrame[["maxMTDYear"]] <- NA
    yearsFrame[["minMTDYear"]] <- NA
    yearsFrame[["maxYTDYear"]] <- NA
    yearsFrame[["minYTDYear"]] <- NA
    
    for (calDate in 1:nrow(yearsFrame)) {
      maxOnDate <- recordsFrame[calDate, "maxMTDPrecip"]
      minOnDate <- recordsFrame[calDate, "minMTDPrecip"]
      maxYTDOnDate <- recordsFrame[calDate, "maxYTDPrecip"]
      minYTDOnDate <- recordsFrame[calDate, "minYTDPrecip"]
      searchFrame <- dplyr::filter(originalFrame,
                                   Month == ccprMonth,
                                   DayOfMonth == calDate)
      maxYear <- dplyr::filter(searchFrame, MTDPrecip == maxOnDate) %>%
        dplyr::top_n(1, Year)
      minYear <- dplyr::filter(searchFrame, MTDPrecip == minOnDate) %>%
        dplyr::top_n(1, Year)
      maxYTDYear <- dplyr::filter(searchFrame, YTDPrecip == maxYTDOnDate) %>%
        dplyr::top_n(1, Year)
      minYTDYear <- dplyr::filter(searchFrame, YTDPrecip == minYTDOnDate) %>%
        dplyr::top_n(1, Year)
      yearsFrame[["maxMTDYear"]][calDate] <- as.character(maxYear[["Year"]][1])
      yearsFrame[["minMTDYear"]][calDate] <- as.character(minYear[["Year"]][1])
      yearsFrame[["maxYTDYear"]][calDate] <- 
        as.character(maxYTDYear[["Year"]][1])
      yearsFrame[["minYTDYear"]][calDate] <-
        as.character(minYTDYear[["Year"]][1])
    }
    
    recordsFrame <- dplyr::full_join(recordsFrame,
                                     yearsFrame,
                                     by = c("Month", "DayOfMonth")) %>%
      dplyr::select(Month,
                    DayOfMonth,
                    maxMTDPrecip,
                    maxMTDYear,
                    minMTDPrecip,
                    minMTDYear,
                    maxYTDPrecip,
                    maxYTDYear,
                    minYTDPrecip,
                    minYTDYear)
    
    # Code to remove labels where they are the same as the previous and 
    # next day's.
    
    # First, make copies of the year variables to use in determining which
    # year labels to remove.
    maxYears <- recordsFrame[["maxMTDYear"]]
    minYears <- recordsFrame[["minMTDYear"]]
    maxYTDYears <- recordsFrame[["maxYTDYear"]]
    minYTDYears <- recordsFrame[["minYTDYear"]]
    
    for (calDate in 2:(nrow(yearsFrame) - 1)) {
      if (maxYears[calDate] == maxYears[calDate - 1] &
            maxYears[calDate] == maxYears[calDate + 1]) {
        recordsFrame[["maxMTDYear"]][calDate] <- ""
      }
      if (minYears[calDate] == minYears[calDate - 1] &
            minYears[calDate] == minYears[calDate + 1]) {
        recordsFrame[["minMTDYear"]][calDate] <- ""
      }
      if (maxYTDYears[calDate] == maxYTDYears[calDate - 1] &
          maxYTDYears[calDate] == maxYTDYears[calDate + 1]) {
        recordsFrame[["maxYTDYear"]][calDate] <- ""
      }
      if (minYTDYears[calDate] == minYTDYears[calDate - 1] &
          minYTDYears[calDate] == minYTDYears[calDate + 1]) {
        recordsFrame[["minYTDYear"]][calDate] <- ""
      }
    }
    
    # Add the current year's data, if desired
    if(showYear) {
      # Filter originalFrame to only include the current year's data
      currentYearFrame <- originalFrame %>%
        dplyr::filter(Year == currentYear, Month == ccprMonth) %>%
        dplyr::mutate(MTD = MTDPrecip, YTD = YTDPrecip) %>%
        dplyr::select(Month, DayOfMonth, MTD, YTD)
      recordsFrame <- dplyr::full_join(recordsFrame,
                                       currentYearFrame,
                                       by = c("Month", "DayOfMonth")) %>%
        dplyr::select(Month,
                      DayOfMonth,
                      maxMTDPrecip,
                      maxMTDYear,
                      MTD,
                      minMTDPrecip,
                      minMTDYear,
                      maxYTDPrecip,
                      maxYTDYear,
                      YTD,
                      minYTDPrecip,
                      minYTDYear)
    }
    
    # Add normals, if desired
    if(includeNormals) {
      # Join normals to the data
      recordsFrame <- dplyr::left_join(recordsFrame,
                                       airportNormals %>%
                                         dplyr::select(
                                           -dplyr::ends_with("re")),
                                       by = c("Month", "DayOfMonth")) %>%
        dplyr::rename(MTDNormal = MTDPrecip, YTDNormal = YTDPrecip)
      if(showYear) {
        recordsFrame <- dplyr::select(recordsFrame,
                                      Month,
                                      DayOfMonth,
                                      maxMTDPrecip,
                                      maxMTDYear,
                                      MTDNormal,
                                      MTD,
                                      minMTDPrecip,
                                      minMTDYear,
                                      maxYTDPrecip,
                                      maxYTDYear,
                                      YTDNormal,
                                      YTD,
                                      minYTDPrecip,
                                      minYTDYear)
      } else {
        recordsFrame <- dplyr::select(recordsFrame,
                                      Month,
                                      DayOfMonth,
                                      maxMTDPrecip,
                                      maxMTDYear,
                                      MTDNormal,
                                      minMTDPrecip,
                                      minMTDYear,
                                      maxYTDPrecip,
                                      maxYTDYear,
                                      YTDNormal,
                                      minYTDPrecip,
                                      minYTDYear)
      }
    }
    
    # If this is February, and showLeapDay is FALSE,
    # hide data for February 29th.
    if(ccprMonth == 2) {
      if(!showLeapDay) {
        recordsFrame <- dplyr::filter(recordsFrame, DayOfMonth != 29)
      }
    }
    
    # TODO: Provide code to print label on Feb 28th if it is missing because
    #       it is identical to Feb 29th. (Not a problem with current data.)
    
    return(recordsFrame)
}
