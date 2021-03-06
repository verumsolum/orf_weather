% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotmaxtempoverhistory.R
\name{plotMaxTempOverHistory}
\alias{plotMaxTempOverHistory}
\title{Plot historical high tempertures on a single date}
\usage{
plotMaxTempOverHistory(wxUniverse = orfwx::allData(),
  plotDate = yesterdate(), daysWeather = NULL, twoTicks = TRUE,
  fiveTicks = FALSE, tenTicks = TRUE, saveToFile = FALSE)
}
\arguments{
\item{wxUniverse}{(optional) The data frame containing the weather history
to be searched (defaults to \code{allData}).}

\item{plotDate}{(optional) The date to be searched for, defaulting to
yesterday's date.}

\item{daysWeather}{(optional) The weather for a date not yet included in
the \code{wxUniverse} data frame, usually passed by the
\code{singleDaysWeather} function.}

\item{twoTicks}{(optional) Writes half ticks (defaults to \code{TRUE}).}

\item{fiveTicks}{(optional) Writes fifth ticks (defaults to \code{FALSE}).}

\item{tenTicks}{(optional) Writes tenth ticks (defaults to \code{TRUE}).}

\item{saveToFile}{(optional) Writes plot to a PNG file (defaults to
\code{FALSE}).}
}
\value{
Returns a barplot.
}
\description{
\code{plotMaxTempOverHistory} creates a barplot with the high temperatures
of one day each year.
}
\details{
If \code{daysWeather} is passed (usually using
\code{\link[=singleDaysWeather]{singleDaysWeather()}}), the function ensures that its weather is
for the same date as that provided by \code{plotDate} (either passed to the
function or the default value of the current system date). If they do not
match, the function terminates with an error message.

The data from \code{daysWeather} is added to that provided by
\code{wxUniverse} (by default, \code{\link[=allData]{allData()}}) and the weather
on the same date each year is compared.

A barplot is plotted by \code{\link[=plotWithManyBars]{plotWithManyBars()}} with the high
temperatures for the same date in all years. The bar for the year provided
by \code{daysWeather} (or, if \code{daysWeather} is not provided, the
year as of yesterday) is highlighted with a bar of a different color in the
barplot.
}
\examples{
plotMaxTempOverHistory(airportData, searchDate(11, 26))  
# Returns plot for November 26th
}
