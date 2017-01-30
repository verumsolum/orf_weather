#' Find most recent date in data
#' 
#' \code{findMostRecentDate} checks a data frame for the most recent date for
#' which observations are included.
#' 
#' Details section to be written.
#' 
#' @param fmrdSource The data frame to check. (Defaults to `updatedData()`).
#' @return Returns a date.
#' @examples
#' \dontrun{
#' findMostRecentDate()
#' }
#' @export
findMostRecentDate <- function(fmrdSource = orfwx::updatedData()) {
  fmrdSource <- dplyr::arrange(fmrdSource, dplyr::desc(Date))
  fmrdSource[[1, "Date"]]
}
