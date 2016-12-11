convertCsvToLogical <- function(reportedValue) {
  if (reportedValue == "0.00") {
    return(FALSE)
  } else if (reportedValue == "M" | is.null(reportedValue)) {
    return(NA)
  } else {
    # If "T" or > 0.00
    return(TRUE)
  }
}
