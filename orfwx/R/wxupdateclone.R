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
  wxucLocalDir <- "~/.orfwx/wxupdaterepo/"
  wxucGitRemote <- "https://github.com/verumsolum/orf_weather.git"

  # Create directory if it does not already exist
  if(!dir.exists(wxucLocalDir)) {
    dir.create(wxucLocalDir, recursive = TRUE)
  }
  
  # Clone the repository
  wxucRepo <- git2r::clone(wxucGitRemote, wxucLocalDir, branch = "wxupdate")
}
