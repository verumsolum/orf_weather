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

### Files:lines affected

* plotcoolestmaxtempoverhistory.R:28 (`todaysHigh`)
* plotcoolestmintempoverhistory.R:28 (`todaysLow`)
* plotmaxtempoverhistory.R:28 (`todaysHigh`)
* plotintempoverhistory.R:28 (`todaysLow`)
* plotprecipitationoverhistory.R:28 (`todaysPrecipitation`)
* plotwarmestmaxtempoverhistory.R:28 (`todaysHigh`)
* plotwarmestmintempoverhistory.R:28 (`todaysLow`)

## Links

* King, W. B. (2016, January 18). [R Objects](https://ww2.coastal.edu/kingw/statistics/R-tutorials/objects.html). _Tutorials_. Retrieved from https://ww2.coastal.edu/kingw/statistics/R-tutorials/objects.html
