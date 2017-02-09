#' Ensures directory exists, optionally create it
#' 
#' `ensureDirectoryExists` ensures that the a directory exists, and, if 
#' it does not, can create it.
#' 
#' By default, this checks for the presence of `~/.orfwx` but does not
#' create that directory if it is missing. Both of those options can be
#' overridden by parameters.
#' 
#' @param whichDirectory The directory that is checked for existence. Defaults
#'   to `~/.orfwx`
#' @param createIfMissing If `TRUE`, create the directory if it does not
#'   exist.
#' @return Logical value: `TRUE` if the directory exists (either it
#'   already existed or was created if `createIfMissing == TRUE`) and
#'   `FALSE` if the directory does not already exist.
#' @examples
#' \dontrun{
#' ensureDirectoryExists("~/.orfwx")
#' }
#' @export
ensureDirectoryExists <- function(whichDirectory = "~/.orfwx",
                                  createIfMissing = FALSE){
  if (!dir.exists(whichDirectory)) {
    if (!createIfMissing) {
      # If the directory does not exist and createIfMissing == FALSE,
      # nothing to do, but return FALSE
      return(FALSE)
    } else if (createIfMissing == TRUE) {
      # If the directory does not exist and createIfMissing == TRUE,
      # create the directory.
      dir.create(whichDirectory)
    } # end inner if (re: createIfMissing)
  }
  
  # Then, in either case, make sure the directory exists
  # (either because it is pre-existing or was created above)
  # and return TRUE or error out.
  if (dir.exists(whichDirectory)) {
    return(TRUE)
  } else {
    eString <- paste("Unsure how we got here: directory",
                     paste0("'",
                            whichDirectory,
                            "'"),
                     "should exist, but appears not to.")
    stop(eString)
  }
}
