#' Returns data frame with all weather observations
#' 
#' `allData` takes [bothStations()] and 
#' [updatedData()] and combines them.
#' 
#' This is a convenience wrapper that uses [combineDataFrames()] to 
#' combine the two data frames, sorted by date.
#' 
#' @return Returns a data frame.
#' @examples
#' allData()
#' @export
allData <- function(){
  dfAll <- combineDataFrames(orfwx::bothStations, orfwx::updatedData())
  return(dfAll)
}
