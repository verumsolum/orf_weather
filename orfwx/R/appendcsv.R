#' Appending a row to a CSV.
#' 
#' \code{append.csv} appends a row or rows to an existing CSV file.
#' 
#' This is a convenience wrapper that uses \code{write.table} to append to 
#' a CSV.
#' 
#' This function is still not well-developed. Users must ensure that the
#' data to be appended to the CSV file has the same fields in the same order.
#' No checking is performed by \code{append.csv}
#' 
#' @param appendData The data frame with the information for the row(s) to be 
#'   appended to the CSV.
#' @param CsvFile The file name of the CSV to which \code{data} is appended.
#' @return No return; appends to the specified file.
#' @examples
#' \dontrun{append.csv()}
#' @export
append.csv <- function(appendData, CsvFile){
  utils::write.table(appendData,
                     file = CsvFile, 
                     quote = FALSE, 
                     row.names = FALSE, 
                     sep = ",", 
                     append = TRUE, 
                     col.names = FALSE)
}
