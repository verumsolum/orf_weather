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
