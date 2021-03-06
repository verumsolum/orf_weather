#' Convert CSV values for precipitation and snowfall to numeric and logical
#' 
#' `convertCsvToNumericAndLogical` adds extra variables to express
#' `CsvPrecipitation` and `CsvSnowfall` in numeric and logical
#' variables.
#' 
#' The variables added are:
#' 
#' * `PrecipitationInches`: The precipitation, accurate to the hundredth of an 
#'   inch (numeric)
#' * `WithPrecipitation`: Logical value indicating whether or not precipitation 
#'   fell on this day
#' * `SnowfallInches`: The snowfall, accurate to the tenth of an inch (numeric)
#' * `WithSnowfall`: Logical value indicating whether or not snow fell on this 
#'   day
#' 
#' @param originalFrame The data frame to which the date variables are 
#'   appended.
#' @return Returns a data frame.
#' @examples
#' convertCsvToNumericAndLogical(airportData)
#' @export
convertCsvToNumericAndLogical <- function(originalFrame){
  # Create two new variables from CsvPrecipitation
  originalFrame <- dplyr::mutate(
    originalFrame,
    PrecipitationInches = dplyr::if_else(is.na(CsvPrecipitation),
                                         NA_real_,
                                         dplyr::if_else(CsvPrecipitation == 
                                                          "T",
                                                        0,
                                                        as.numeric(
                                                          as.character(
                                                            CsvPrecipitation)))
                                         ),
    WithPrecipitation = dplyr::if_else(is.na(CsvPrecipitation),
                                       NA,
                                       dplyr::if_else(CsvPrecipitation == "T",
                                                      TRUE,
                                                      as.logical(
                                                        PrecipitationInches))
                                       ),
    # Create two new variables from CsvSnowfall
    SnowfallInches = dplyr::if_else(is.na(CsvSnowfall),
                                    NA_real_,
                                    dplyr::if_else(CsvSnowfall == "T",
                                                   0,
                                                   as.numeric(as.character(
                                                     CsvSnowfall)))),
    WithSnowfall = dplyr::if_else(is.na(CsvSnowfall),
                                  NA,
                                  dplyr::if_else(CsvSnowfall == "T",
                                                 TRUE,
                                                 as.logical(SnowfallInches)))
    )
  return(originalFrame)
}
