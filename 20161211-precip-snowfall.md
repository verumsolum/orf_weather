# 20161211-precip-snowfall

This branch is for converting precip and snowfall each into two columns,
one representing the amount that fell,
and the other representing whether or not any fell.
(This is to deal with the way the National Weather Service records trace
precipitation or snowfall with `T`, when it is too little to be measured.)

## Status

As of December 13, 2016, 
the columns have been added to the mutatedBothStations data.

## Next step

Next is to make sure that none of the functions are relying on the
now-removed `Precipitation` and `Snowfall` variables.
They should now use `PrecipitationInches` and/or `WithPrecipitation`
(or the snowfall complements) instead.

## Known issues

* `plotPrecipitationOverHistory` obviously uses the precip data.
* `singleDaysWeather` and all functions that may be passed that as a parameter
(all plot functions?) will need to be examined to ensure that they continue to
work.
