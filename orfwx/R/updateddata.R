#' Converting updated CSV to a data frame
#' 
#' \code{updatedData} turns the updated data (retrieved using 
#' \code{\link{getUpdatedCsv}}) into a data frame, which may be combined with
#' other data using \code{\link{combineDataFrames}}.
#' 
#' Details section to be written.
#' 
#' @param runUpdate If \code{TRUE}, uses \code{\link{getUpdatedCsv}} to
#'   retrieve updated data
#' @return Returns a data frame
#' @examples
#' \dontrun{updatedData()}
#' @export
updatedData <- function(runUpdate = FALSE){
  fLocation <- "~/.orfwx/updates.csv"
  # Retrieve updates, if runUpdate == TRUE
  if (runUpdate == TRUE) {
    getUpdatedCsv()
  } else if (!file.exists(fLocation)) {
    stop("~/.orfwx/updates.csv is missing and runUpdate == FALSE")
  }
  
  # Read updated Norfolk airport weather data from CSV
  csvData <- utils::read.csv(fLocation,
                             colClasses = c("Date",
                                            "integer",
                                            "integer",
                                            "numeric",
                                            "character",
                                            "character"),
                             strip.white = TRUE,
                             na.strings = c("M", NULL)
                             )
  
  # Rename Precipitation and Snowfall variables, so we don't have to do it later
  csvData <- dplyr::rename(csvData,
                           CsvPrecipitation = Precipitation,
                           CsvSnowfall = Snowfall)
  
  # TODO: Check for duplicate or missing dates
  
  # Convert to tibble
  csvData <- dplyr::tbl_df(csvData)
}
