#' Deletes out-dated backup files
#' 
#' `removeBackups` deletes out-of-date backup files.
#' 
#' The [getUpdatedCsv()] function downloads `updates.csv` to the
#' `~/.orfwx/` directory. In case of error, that function also copies the
#' existing `~/.orfwx/updates.csv` and renames it, so that it can be used
#' in case of a corrupted download. This `removeBackups` function deletes
#' some of those backup files.
#' 
#' If called without parameters, `removeBackups` will delete all files that
#' are older than approximately one week. If `leaveOne` is set to 
#' `TRUE`, all backup files other than the most recent file will be 
#' deleted.
#' 
#' @param leaveOne (Defaults to `FALSE`) If `TRUE`, delete all backup
#'   files except the most recent. Otherwise, any folder newer than 
#'   approximately a week will be left and older files will be deleted.
#' @return Deletes files from `~/.orfwx/` directory.
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
  
  rbFiles <- paste0(rbPath, rbFiles) %>%
    sort(decreasing = TRUE)
  
  if(leaveOne) {
    for(f in 2:length(rbFiles)) {  # Start with 2 so most recent not deleted
      invisible(file.remove(rbFiles[f]))
    }
  } else {
    rbInfo <- file.info(rbFiles) %>%
      as_tibble() %>%
      rownames_to_column(var = "filename") %>%
      dplyr::filter(ctime <= Sys.time() - 604800) %>%  # Only those >7 days old
      .[-1, ]  # Exclude the most recent file
    invisible(file.remove(rbInfo[["filename"]]))
  }
}
