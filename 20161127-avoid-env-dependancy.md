# 20161127-avoid-env-dependency

## Issue

**Many functions in orfwx depend on environment variables which may be missing** - [#11](https://github.com/verumsolum/orf_weather/issues/11)

### Discussion (aka "Thinking out loud")

In the original files,
there was an assumption that
`orfwxfunctions.R`
would be `source`d by
`orfwx.R`.
That file defines a number of variables,
particularly
`currentDate`,
`todaysHigh`,
`todaysLow`,
and
`todaysPrecipitation`.

Many of the functions in the `orfwx` package
(as of version 0.0.0.9009)
expect one or more of those variables
to be present in
R's global environment,
and will fail if they do not exist.

My current idea is to create a function
`singleDaysWeather` (?)
which will generate
a data frame (?)
or
a named vector (see King 2016a)
with a single day's data,
for use with temporary data.

Then,
instead of the current hard-coded addition 
of the current year's data,
the functions can take an optional argument.
That argument would receive
the return value from 
`singleDaysWeather`
with a default value of
`NULL` (see Cotton 2015).
If it is
`NULL` 
(i.e., "missing"),
the function will only use data
from the included dataset.
If the argument is provided,
that information
will be added.

#### Decisions to be made

##### Precipitation and Snowfall

The current dataframe
`mutatedBothStations'
defines
`Precipitation`
and
`Snowfall`
as factors.
They can not be defined as numbers,
because the "T" for trace precipitation or snowfall
could not be distinguished from 0.00.
The factors' character values all include a space
prior to the first digit in the string,
which should be trimmed,
if these are staying as strings.

The big question to answer:
Should I hard-code a space and make these character values
in the 'singleDaysWeather' function?
Or should I fix the code in `data-raw/`
to strip the leading space character?
and/or to make these strings no longer factors?

##### Hardcoded 2016 [fixed in 20161129-hardcoded-2016]

Doing the simple fix
of using the year of the system date
instead of 2016
for coloring the current year in barplots.

A later fix will be required
to allow plotting to work properly
when a previous year is
the "current year" for the data
(e.g., plotting data for 12/31/2016 on 1/1/2017).
This will probably be beyond the scope of this branch,
and a Github issue should be filed 
if this branch is closed
without solving that issue.

### Files:lines affected

* plotcoolestmaxtempoverhistory.R:28 (`todaysHigh`)
* plotcoolestmintempoverhistory.R:28 (`todaysLow`)
* plotmaxtempoverhistory.R:28 (`todaysHigh`)
* plotintempoverhistory.R:28 (`todaysLow`)
* plotprecipitationoverhistory.R:28 (`todaysPrecipitation`)
* plotwarmestmaxtempoverhistory.R:28 (`todaysHigh`)
* plotwarmestmintempoverhistory.R:28 (`todaysLow`)

## Links

* Cotton, R. (2015, April 14). [Should I use NULL or NA as default values for optional function parameters](http://stackoverflow.com/a/29620701). [answer] _Stack Overflow_. Retrieved from http://stackoverflow.com/a/29620701
* Kabacoff, R. I. (2014). [Operators](http://www.statmethods.net/management/operators.html). _Quick-R_. Retrieved from http://www.statmethods.net/management/operators.html
* King, W. B. (2016a, January 18). [R Objects](https://ww2.coastal.edu/kingw/statistics/R-tutorials/objects.html). _Tutorials_. Retrieved from https://ww2.coastal.edu/kingw/statistics/R-tutorials/objects.html
* King, W. B. (2016b, January 21). [Data Frames](https://ww2.coastal.edu/kingw/statistics/R-tutorials/dataframes.html). _Tutorials_. Retrieved from https://ww2.coastal.edu/kingw/statistics/R-tutorials/dataframes.html
