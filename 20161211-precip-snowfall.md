# 20161211-precip-snowfall
## 20161213-use-new-precip-snow-vars sub-branch

This branch is for converting precip and snowfall each into two columns,
one representing the amount that fell,
and the other representing whether or not any fell.
(This is to deal with the way the National Weather Service records trace
precipitation or snowfall with `T`, when it is too little to be measured.)

## Status

As of December 13, 2016, 
and version 0.0.0.9023,
the columns have been added to the mutatedBothStations data.
`singleDaysWeather` has been updated.
This should allow all the plotting functions,
with the exception of
`plotPrecipitationOverHistory`,
to work with the new precipitation columns.

## Next step

Next is to make sure that 
`plotPrecipitationOverHistory` 
is now relying on the
`PrecipitationInches`
variable, 
instead of the
now-removed `Precipitation` and `Snowfall` variables.

## Known issues

* `plotPrecipitationOverHistory` obviously uses the precip data.
