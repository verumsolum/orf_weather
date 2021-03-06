% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/updateddata.R
\name{updatedData}
\alias{updatedData}
\title{Converting updated CSV to a data frame}
\usage{
updatedData(runUpdate = FALSE)
}
\arguments{
\item{runUpdate}{If \code{TRUE}, uses \code{\link[=getUpdatedCsv]{getUpdatedCsv()}} to
retrieve updated data (defaults to \code{FALSE}).}
}
\value{
Returns a data frame
}
\description{
\code{updatedData} turns the updated data (retrieved using
\code{\link[=getUpdatedCsv]{getUpdatedCsv()}}) into a data frame, which may be combined with
other data using \code{\link[=combineDataFrames]{combineDataFrames()}}.
}
\details{
Details section to be written.
}
\examples{
\dontrun{updatedData()}
}
