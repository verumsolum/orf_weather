#' Combines two data frames with weather observations
#' 
#' \code{getUpdatedCsv} takes two data frames and combines them.
#' 
#' This is a convenience wrapper that uses \code{httr} to download an
#' \code{updates.csv} file
#' 
#' @return Downloads a file to the working directory.
#' @examples
#' \dontrun{getUpdatedCsv()}
#' @export
getUpdatedCsv <- function(){
  gucURL <- "https://github.com/verumsolum/orf_weather/raw/wxupdate/orfwx/data-raw/updates.csv"
  hResponse <- httr::GET(gucURL)
  fileContents <- httr::content(hResponse, "raw")
  fLocation <- "~/.orfwx/updates.csv"
  bfTimestamp <- strftime(Sys.time(), "%Y%m%d%H%M%S")
  bfName <- paste0("~/.orfwx/updates.", bfTimestamp, ".backup.csv")
  # If the file exists, rename it (as a backup), and then overwrite with 
  # the new file.
  if (file.exists(fLocation)) {
    file.rename(fLocation, bfName)
    if (!file.exists(bfName)) {
      stop("Backup file does not appear to have been created")
    }
  }
  # Because we have renamed the existing file (if it existed), 
  # it should not exist at the name we want to use. But just in case...
  if (!file.exists(fLocation)) {
    # First, make sure the directory exists, then write the file.
    if (!ensureDirectoryExists(createIfMissing = TRUE)) {
      stop("Directory does not exist and apprently could not be created.")
    }
    writeBin(fileContents, fLocation)
  } else {
    stop(paste("Update not written to file: A file at",
               fLocation,
               "still exists after renaming."))
  }
}