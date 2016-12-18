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
