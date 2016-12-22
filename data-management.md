# orfwx Data Management

## Current situation (2016-12-18)

Currently,
All the data is stored in a single object,
`mutatedBothStations`,
which is read from two CSV files
and then mutated
from with the
`data-raw/readweatherdata.R` file.

Updates are added to
`data-raw/NorfolkIntlAp.csv`
and periodically,
`data-raw/readweatherdata.R`
is run to update the
`data/mutatedBothStations.rda`
data file that is loaded by the
`orfwx`
package.

### Status

The mutation functions
have been removed from
`data-raw/readweatherdata.R`
and
added into their own functions
with the `orfwx` package.

The functions which depend on
`mutatedBothStations`
must still be adapted for the new changes.

Also, some of the changes are still incomplete.

#### To-do list

* Adapt functions which rely upon
`mutatedBothStations`
* Figure out how to update data more easily

### Deficiencies of the current situation

#### Manual data updating

Data is updated by manually updating a CSV file.
Bulk updates are possible by
copy and pasting from
http://climodtest.nrcc.cornell.edu/

I am sure that
the National Weather Service (NWS) and/or
its parent, NOAA,
offer downloadable files which may be suitable
and may be able to update
without risk of typos.

I believe
http://www.rcc-acis.org/docs_webservices.html
may document access to the data used by
CLIMOD,
in a way that may be easier to incorporate into orfwx,
but I have not wrapped my head around
either
the documentation
or
what it might mean to incorporate it into an R workflow.

### Creation of extra variables

Currently,
there are a number of extra variables,
beyond those in the source data.
Some of these are for convenience;
others are for specific calculations.

These extra variables are currently created
at the time the
`mutatedBothStations`
data object is created.
As a result,
they are always part of the results returned,
even when they are irrelevant to the current use of
`mutatedBothStations`
(unless removed using
`dplyr::select`).

This causes difficulties for
`singleDaysWeather`, 
which must re-create these adaptations for that day's weather.

I believe these adaptations should be removed from
`data-raw/readweatherdata.R`
and moved into functions
within the 'orfwx' package.

Each adaptation
(or related group of adaptations)
should be a separate function,
so that the appropriate variables for each use can be included,
and irrelevant variables easily excluded.

There is likely a place for a
"show all information" function,
which will collect all these extra variables,
for those situations
where one wishes as much information as possible about each day's weather.

### Plan for updating data

* Create a CSV to include updated observations since the last `orfwx` release.
  * That CSV will be created in its own branch of the repository.
    * It has been created at
    https://github.com/verumsolum/orf_weather/raw/wxupdate/orfwx/data-raw/updates.csv
    and is updated in the
    `wxupdate`
    branch of the repository.
  * Eventually, that CSV will be downloaded from within R to add to the data
  packaged with
  `orfwx`
* Create a function to combine the raw observation files.
  * This can be used to combine
  `airportData`
  with
  `earlyDowntownData`
  and/or with the downloadable update file.
  * This can also be used to combine whatever data source with
  `singleDaysWeather`
    * **NOTE**: Updates to
    `singleDaysWeather` will be required, as it currently does much of the
    mutating that used to be found in
    `data-raw/readweatherdata.R`
    The new version should be much simpler.