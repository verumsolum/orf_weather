#' Add ticks to y-axis of grid.
#' 
#' \code{tickTenth} adds ten smaller ticks in between the full ticks.
#' 
#' The smaller ticks are \frac{1}{3} the size of the full ticks.
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
