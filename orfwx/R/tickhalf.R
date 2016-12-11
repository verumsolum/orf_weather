#' Add ticks to y-axis of grid.
#' 
#' \code{tickHalf} adds a smaller tick in between the full ticks.
#' 
#' The smaller ticks are \frac{2}{3} the size of the full ticks.
#' 
#' @examples
#' \dontrun{tickHalf()}
tickHalf=function(){
  if (requireNamespace("Hmisc", quietly = TRUE)) {
    Hmisc::minor.tick(nx = 1,
                      ny = 2,
                      tick.ratio = 0.67)
  }
}
