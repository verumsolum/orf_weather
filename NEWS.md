# verumsolum/orf_weather

**WARNING:** This package is still under heavy initial development, and I am
not an experienced developer and I am still faily new to R, so while I am
doing my best to understand and follow best practices, I do not guarantee that
I am successful in that undertaking.

## 0.0.0.9000+ (Current development)

**NOTE:** Changes made prior to 2017-01-01 are not documented in this file.
Consult [the Github repository](github.com/verumsolum/orf_weather) if you
require details about earlier changes.

### Changes in version 0.0.0.9051 (2017-02-10)
* **getUpdatedCsv**: Updated documentation to remove outdated reference to use
of `httr` package.

### Changes in version 0.0.0.9050 (2017-02-09)
* Documentation updated to Markdown format using roxygen2 version 6.0.1 
(Initial conversion using roxygen2md version 0.0-2)

### Changes in version 0.0.0.9049 (2017-02-09)
* **computeCumulativePrecipRecords**: Label Feb28th in all cases if
\code{showLeapDay} is \code{TRUE}.

### Changes in version 0.0.0.9048 (2017-02-09)
* **removePlotFiles**: Function added to remove PNG files from working
directory.

### Changes in version 0.0.0.9047 (2017-02-09)
* **computeCumulativePrecipRecords**: Add `showLastCompleteMonth`
parameter for use when you would prefer last year's data to that of the month in
progress. Also, exclude the plotted year (and more recent) from the calculation 
of records. A correction was also made to the documentation example.
* **plotMTDPrecipitation** and **plotYTDPrecipitation**: Add 
`showLastCompleteMonth` parameter to pass through to 
`computeCumulativePrecipitationRecords`.

### Changes in version 0.0.0.9046 (2017-02-02)
* *showLeapDay* parameter: Added to `computeCumulativePrecipRecords` and
`plot?TDPrecipitation`functions. Data for Feb 29th will be hidden from those
functions unless `showLeapDay` is set to `TRUE`. (Defaults to `TRUE` during leap
years and `FALSE` at all other times.)

### Changes in version 0.0.0.9045 (2017-02-02)
* **removeBackups**: Function added to remove backup files from `/.orfwx/` 
directory (either after seven days, or all but the most recent backup files).

### Changes in version 0.0.0.9044 (2017-01-30)
* *saveToFile* parameter: Added to all `plot*` functions to direct function to
save plot to file. (Defaults to `FALSE`.)  
**WARNING:** The default for the `saveToFile` parameter is likely to change.
It currently is set to `FALSE` while ensuring that there are no bugs or 
unwelcome side effects, but I do hope to change it to `TRUE`, to make it easier
for me to use this package.

### Changes in version 0.0.0.9043 (2017-01-30)
* **findMostRecentDate**: Find most recent date in a data frame (defaults to
`updatedData`)
* **getUpdatedCsv**: Report back to the user with the most recent date contained
in the update.

### Changes in version 0.0.0.9042 (2017-01-18)
* **plotWarmestMinTempOverHistory**: Change `wxUniverse` parameter to default to
`allData` (This function was missed in 0.0.0.9039)

### Changes in version 0.0.0.9041 (2017-01-18)
* **firstSunday**: Function to return the date of the first Sunday in a month
* **plotMTDPrecipitation**: Label axis with ticks and labels each Sunday
* **plotYTDPrecipitation**: Label axis with ticks and labels each Sunday, tweak
alignment and placement of year labels

### Changes in version 0.0.0.9040 (2017-01-14)
* **plotYTDPrecipitation**: New year-to-date plot based on 
`plotMTDPrecipitation`.

### Changes in version 0.0.0.9039 (2017-01-13)
* *wxUniverse*: Change parameter in several functions to default to `allData`,
rather than `bothStations`

### Changes in version 0.0.0.9038 (2017-01-10)
* **computeCumulativePrecipRecords**: Add `includeNormals` parameter to
include normals in data frame
* *Data*: Add `ApNormals1981-2010.csv` to `data-raw` directory, convert to
`airportNormals` dataset
* **plotMTDPrecipitation**: Add normals to plot

### Changes in version 0.0.0.9037 (2017-01-09)
* **computeCumulativePrecipitation**: Add `computeCumulativePrecipitation`
function to calculate `MTDPrecip` and `YTDPrecip` variables
* **computeCumulativePrecipRecords**: Find records (and years) for
`MTDPrecip` and `YTDPrecip`
* **plotMTDPrecipitation**: Plot month-to-date precipitation, with historical
maximum and minimum month-to-date precipitation totals.
* **%>%**: Import function from `dplyr`

### Changes in version 0.0.0.9036 (2017-01-06)
* **getUpdatedCsv**: Use `utils::download.file` instead of `httr:` functions

### Changes in version 0.0.0.9035 (2017-01-05)
* **airportData**, **bothStations**: Update data to end of 2016
* **updatedData**: Update function to ensure only one set of observations is
included for each day

### Changes in version 0.0.0.9034 (2017-01-05)
* **allData**: Explicitly reference package in default values for parameters.
(So it can be used with `orfwx::` notation, if the package is not loaded.)

### Changes in version 0.0.0.9033 (2017-01-02)
* **2016.md**, **2016.Rmd**: Create "2016 in Review" summary report
* **plot* functions**: Change `plotDate` default to `yesterdate`
