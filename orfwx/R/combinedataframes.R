#' Combines two data frames with weather observations
#' 
#' \code{combineDataFrames} takes two data frames and combines them.
#' 
#' This is a convenience wrapper that uses \code{rbind} to combine two data
#' frames, then sorts the resulting data frame by date.
#' 
#' No error checking is done: Users should ensure that both data frames are
#' in the proper format.
#' 
#' @param dfOne The first data frame.
#' @param dfTwo The second data frame, which is added to the first.
#' @return Returns a data frame.
#' @examples
#' combineDataFrames(earlyDowntownData, airportData)
#' @export
combineDataFrames <- function(dfOne, dfTwo){
  cdf <- rbind(dfOne, dfTwo)
  cdf <- dplyr::arrange(cdf, Date)
  return(cdf)
}
