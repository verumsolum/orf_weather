#' Add ticks to y-axis of grid.
#' 
#' `tickTenth` adds ten smaller ticks in between the full ticks.
#' 
#' The smaller ticks are one-third the size of the full ticks.
#' 
#' @examples
#' \dontrun{tickTenth()}
tickTenth=function(){
  if (requireNamespace("Hmisc", quietly = TRUE)) {
    Hmisc::minor.tick(nx = 1,
                      ny = 10,
                      tick.ratio = 0.33)
  }
}
