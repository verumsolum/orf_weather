# 20161211-precip-snowfall

This branch is for converting precip and snowfall each into two columns,
one representing the amount that fell,
and the other representing whether or not any fell.
(This is to deal with the way the National Weather Service records trace
precipitation or snowfall with `T`, when it is too little to be measured.)

## Status

As of December 14, 2016, 
and version 0.0.0.9025,
the columns have been added to the mutatedBothStations data.
`singleDaysWeather` has been updated.
All the plotting functions,
including
`plotPrecipitationOverHistory`,
now work with the new precipitation columns.
