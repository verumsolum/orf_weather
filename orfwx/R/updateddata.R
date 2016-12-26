#' Converting updated CSV to a data frame
#' 
#' \code{updatedData} turns the updated data (retrieved using 
#' \code{\link{getUpdatedCsv}}) into a data frame, which may be combined with
#' other data using \code{\link{combineDataFrames}}.
#' 
#' Details section to be written.
#' 
#' @return Returns a data frame
#' @examples
#' \dontrun{updatedData()}
#' @export
updatedData <- function(){
  # TODO: Check for existance of file
  
  # Read updated Norfolk airport weather data from CSV
  csvData <- utils::read.csv("~/.orfwx/updates.csv",
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
