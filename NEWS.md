# verumsolum/orf_weather

**WARNING:** This package is still under heavy initial development, and I am
not an experienced developer and I am still faily new to R, so while I am
doing my best to understand and follow best practices, I do not guarantee that
I am successful in that undertaking.

## 0.0.0.9000+ (Current development)

**NOTE:** Changes made prior to 2017-01-01 are not documented in this file.
Consult [the Github repository](github.com/verumsolum/orf_weather) if you
require details about earlier changes.

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
