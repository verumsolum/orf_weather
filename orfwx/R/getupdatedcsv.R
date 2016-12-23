#' Combines two data frames with weather observations
#' 
#' \code{getUpdatedCsv} takes two data frames and combines them.
#' 
#' This is a convenience wrapper that uses \code{httr} to download an
#' \code{update.csv} file
#' 
#' @return Downloads a file to the working directory.
#' @examples
#' \dontrun{getUpdatedCsv()}
#' @export
getUpdatedCsv <- function(){
  gucURL <- "https://github.com/verumsolum/orf_weather/raw/wxupdate/orfwx/data-raw/updates.csv"
  hResponse <- httr::GET(gucURL)
  fileContents <- httr::content(hResponse, "raw")
  # writeBin(fileContents, filename)  # TODO: Where should we write the file?
}
