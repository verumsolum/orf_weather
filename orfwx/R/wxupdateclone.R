#' Retrieves a copy of the repository to upload updated weather data.
#' 
#' `wxUpdateClone` clones the Git repository with the `updates.csv` file
#' contained in it.
#' 
#' Details section to be written.
#' 
#' @return Downloads a repository to the `~/.orfwx/wxupdaterepo/` directory.
#' @examples
#' \dontrun{
#' wxUpdateClone()
#' }
#' @export
wxUpdateClone <- function(){
  wxucLocalDir <- path.expand("~/.orfwx/wxupdaterepo/")
  wxucGitRemote <- "https://github.com/verumsolum/orf_weather.git"

  # I have been having difficulty with cloning through git2r.
  # Now working with a previously cloned repository.
  
  # Return the repository object
  wxucRepo <- git2r::repository(wxucLocalDir)
  wxucRepo
}
