#' Deletes out-dated backup files
#' 
#' \code{removeBackups} deletes out-of-date backup files.
#' 
#' The \code{\link{getUpdatedCsv}} function downloads \code{updates.csv} to the
#' \code{~/.orfwx/} directory. In case of error, that function also copies the
#' existing \code{~/.orfwx/updates.csv} and renames it, so that it can be used
#' in case of a corrupted download. This \code{removeBackups} function deletes
#' some of those backup files.
#' 
#' If called without parameters, \code{removeBackups} will delete all files that
#' are older than approximately one week. If \code{leaveOne} is set to 
#' \code{TRUE}, all backup files other than the most recent file will be 
#' deleted.
#' 
#' @param leaveOne (Defaults to \code{FALSE}) If \code{TRUE}, delete all backup
#'   files except the most recent. Otherwise, any folder newer than 
#'   approximately a week will be left and older files will be deleted.
#' @return Deletes files from \code{~/.orfwx/} directory.
#' @examples
#' \dontrun{
#' removeBackups()
#' }
#' @export
#' @importFrom tibble as_tibble
#' @importFrom tibble rownames_to_column
removeBackups <- function(leaveOne = FALSE) {

  # # Important model lines from getUpdatedCsv
  # fLocation <- "~/.orfwx/updates.csv"
  # bfName <- paste0("~/.orfwx/updates.", bfTimestamp, ".backup.csv")
  
  rbPath <- "~/.orfwx/"
  rbPattern <- "updates.*.backup.csv"
  rbFiles <- list.files(rbPath, pattern = rbPattern)
  
  if(leaveOne) {
    for(f in 2:length(rbFiles)) {  # Start with 2 so most recent not deleted
      file.remove(rbFiles[f])
    }
  } else {
    rbFiles <- paste0(rbPath, rbFiles)
    rbInfo <- file.info(rbFiles) %>%
      as_tibble() %>%
      rownames_to_column(var = "filename") %>%
      dplyr::filter(ctime <= Sys.time() - 604800)
    browser()
  }
  
  # # If the file exists, rename it (as a backup), and then overwrite with 
  # # the new file.
  # if (file.exists(fLocation)) {
  #   file.rename(fLocation, bfName)
  #   if (!file.exists(bfName)) {
  #     stop("Backup file does not appear to have been created")
  #   }
  # }
  # # Because we have renamed the existing file (if it existed), 
  # # it should not exist at the name we want to use. But just in case...
  # if (!file.exists(fLocation)) {
  #   # First, make sure the directory exists, then write the file.
  #   if (!ensureDirectoryExists(createIfMissing = TRUE)) {
  #     stop("Directory does not exist and apprently could not be created.")
  #   }
  #   utils::download.file(gucURL, fLocation)
  #   # Notify the user whether or not the update is up-to-date or not
  #   lastUpdated <- orfwx::findMostRecentDate()
  #   if(lastUpdated == orfwx::yesterdate()) {
  #     message(paste0("UP TO DATE! Updated through yesterday (", 
  #                    lastUpdated, 
  #                    ")"))
  #   } else {
  #     message(paste("OUT OF DATE\n-----------\nMost recent date included:",
  #                   lastUpdated))
  #   }
  # } else {
  #   stop(paste("Update not written to file: A file at",
  #              fLocation,
  #              "still exists after renaming."))
  # }
}
