# verumsolum/orf_weather
## 20161215-data-update-system branch

This branch is intended to create a system
where updated data can be pulled into R,
without requiring the data within the orfwx package to be updated each day.

## Changes made in this branch

* `append.csv`
  * Function to append to a CSV file.
  
## Future plans

* Create an object with the day's data that includes all the columns in
`mutatedBothStations`
* Perhaps pull out portions of
`readweatherdata.R`
which need to happen to
both the package's internal data
and the daily data to be appended,
so that both can call a common function.
* Let's reimagine the setup
instead of simply solving the current issue.
This idea is bigger than a bullet point,
so expand it in a new whiteboard file:
[`data-management.md`](data-management.md)
