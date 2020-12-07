# `importhaver`

## About

This package provides a function, `import_haver`, that is a wrapper around the
`haver.data` function from the `Haver` package. `import_haver` always returns 
data in a tibble with the dates as a variable, rather than a `ts` class object 
or a named vector. `import_haver` also calls `parse_haver_codes` which allows 
the user to supply haver series in the format SERIES@DATABASE, rather than the 
database:series format required by the `Haver` package.

## Installation

The main dependency of the package is the `Haver` package, published by Haver 
Analytics. To install the package, run the following line of code:

```r
install.packages("Haver", repos="http://www.haver.com/r/", type="win.binary")
```

After installing the `Haver` package, you can use `devtools` to install `importhaver` from the Gitlab sever:

```r
devtools::install_gitlab(host = "gitlab1.economic.research", repo ="r-tools/importhaver")
```

## Setting your Haver Directory

Finally, you also want to set up the default Haver directory so R knows where to look for the data.

To do this, you want to edit your .Rprofile file that runs on startup.

```r
usethis::edit_r_profile()
```

Add the following line and save:

```r
.dlxdbpath = "R:/_appl/Haver/DATA/"
```

## Usage

To import a series, you must pass a (optionally named) character vector of Haver series codes.

```r
import_haver(series = c("GDPH@USECON"))

# A tibble: 295 x 2
   date        gdph
   <date>     <dbl>
 1 1947-03-31 2033.
 2 1947-06-30 2028.
 3 1947-09-30 2024.
 4 1947-12-31 2055.
 5 1948-03-31 2086 
 6 1948-06-30 2120.
 7 1948-09-30 2133.
 8 1948-12-31 2135 
 9 1949-03-31 2106.
10 1949-06-30 2098.
# ... with 285 more rows
```

```r
import_haver(series = c(real_gdp = "GDPH@USECON"))

# A tibble: 295 x 2
   date       real_gdp
   <date>        <dbl>
 1 1947-03-31    2033.
 2 1947-06-30    2028.
 3 1947-09-30    2024.
 4 1947-12-31    2055.
 5 1948-03-31    2086 
 6 1948-06-30    2120.
 7 1948-09-30    2133.
 8 1948-12-31    2135 
 9 1949-03-31    2106.
10 1949-06-30    2098.
# ... with 285 more rows
```

Series must have the same frequency; pulling two series with different frequencies will result in an error.

```r
import_haver(series = c("FFED@DAILY", "LR@USECON"))

 Error: Series have multiple frequencies 
```

You can specify a specific timespan using the `start` and `end` parameters that get passed on to `Haver::haver.data`.

```r
import_haver(series = "LR@USECON", start = lubridate::ymd("2020-01-01"), end = lubridate::ymd("2020-10-01"))

# A tibble: 10 x 2
   date          lr
   <date>     <dbl>
 1 2020-01-31   3.6
 2 2020-02-29   3.5
 3 2020-03-31   4.4
 4 2020-04-30  14.7
 5 2020-05-31  13.3
 6 2020-06-30  11.1
 7 2020-07-31  10.2
 8 2020-08-31   8.4
 9 2020-09-30   7.9
10 2020-10-31   6.9
```

For monthly, quaterly, and annual data, you can specify whether you want to use end of period or start of period dates with the `eop` paramter; the default is `TRUE`. For start of period dates, set `eop = FALSE`.

For more advanced toics, such as data aggregation and frequency, see `help("haver.data", package = "Haver")`


