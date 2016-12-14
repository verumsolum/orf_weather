# verumsolum/orf_weather

This directory contains code used in the creation of tweets from the [@ORF_Weather](https://twitter.com/ORF_Weather) Twitter account.

## Status

As of December 14, 2016, 
this code has recently been adapted
from a file of functions created as I learned to use R
into an R package.
This code
is far from what an experienced R user would probably write.

## Main functions

### Ordinary daily graphs

Three functions 
to compare the weather conditions on the same day of each year:
`plotMaxTempOverHistory`, 
`plotMinTempOverHistory`, and
`plotPrecipitationOverHistory`.

### Record weather daily graphs

Four functions
to display record (and almost-record) temperatures
on the same day of each year:
`plotCoolestMaxTempOverHistory`,
`plotCoolestMinTempOverHistory`,
`plotWarmestMaxTempOverHistory`, and
`plotWarmestMinTempOverHistory`.
