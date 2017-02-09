#' Add ticks to y-axis of grid.
#' 
#' `tickFifth` adds five smaller ticks in between the full ticks.
#' 
#' The smaller ticks are one-half the size of the full ticks.
#' 
#' @examples
#' \dontrun{tickFifth()}
tickFifth=function(){
  if (requireNamespace("Hmisc", quietly = TRUE)) {
    Hmisc::minor.tick(nx = 1,
                      ny = 5,
                      tick.ratio = 0.5)
  }
}
