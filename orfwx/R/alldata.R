#' Returns data frame with all weather observations
#' 
#' \code{allData} takes \code{\link{bothStations}} and 
#' \code{\link{updatedData}} and combines them.
#' 
#' This is a convenience wrapper that uses \code{\link{combineDataFrames}} to 
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