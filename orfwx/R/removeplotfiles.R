#' Deletes plot files from working directory
#' 
#' \code{removePlotFiles} deletes \code{*.png} files from the working directory.
#' 
#' This function deletes all PNG files from the working directory.
#' 
#' @param rpfDir (optional) The directory to remove files from (defaults to the
#'   working directory).
#' @return Deletes files from working directory.
#' @examples
#' \dontrun{
#' removePlotFiles()
#' }
#' @export
removePlotFiles <- function(rpfDir = getwd()) {

  # # Important model lines from getUpdatedCsv
  # fLocation <- "~/.orfwx/updates.csv"
  # bfName <- paste0("~/.orfwx/updates.", bfTimestamp, ".backup.csv")
  
  rpfPath <- rpfDir
  rpfPattern <- "*.png"
  rpfFiles <- list.files(rpfPath, pattern = rpfPattern)
  
  rpfFiles <- paste0(rpfPath, rpfFiles)
  
  for(f in 1:length(rpfFiles)) {
    invisible(file.remove(rpfFiles[f]))
  }
}
