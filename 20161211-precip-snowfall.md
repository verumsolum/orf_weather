# 20161211-precip-snowfall
## 20161213-use-new-precip-snow-vars sub-branch

This branch is for converting precip and snowfall each into two columns,
one representing the amount that fell,
and the other representing whether or not any fell.
(This is to deal with the way the National Weather Service records trace
precipitation or snowfall with `T`, when it is too little to be measured.)

## Status

As of December 13, 2016, 
and version 0.0.0.9024,
the columns have been added to the mutatedBothStations data.
`singleDaysWeather` has been updated.
All the plotting functions,
including
`plotPrecipitationOverHistory`,
now work with the new precipitation columns.

## Next step

Testing
`singleDaysWeather` has some issues with error
`Error in if (snowfall != "T") { : missing value where TRUE/FALSE needed`
when `snowfall` is `NA`.

## Known issues

* Errors in 
`singleDaysWeather`
when parameters are 
`NA`
