convertCsvToLogical <- function(reportedValue) {
  ifelse(reportedValue == "0.00",
         return(FALSE),  # if "0.00"
         ifelse(reportedValue == "M" | is.null(reportedValue),
                return(NA),  # if "M" or NULL
                return(TRUE)))  # otherwise
}
