# `importhaver`

## About

This package provides a function, `import_haver`, that is a wrapper around the
`haver.data` function from the `Haver` package. `import_haver` always returns 
data in a tibble with the dates as a variable, rather than a `ts` class object 
or a named vector. `import_haver` also calls `parse_haver_codes` which allows 
the user to supply haver series in the format SERIES@DATABASE, rather than the 
database:series format required by the `Haver` package.

## Installation

To install the package from Gitlab, use the `install_git` function from 
`devtools`. You will also need to authenticate your SSH credentials.

```r
creds <- git2r::cred_ssh_key(private = "C:/Users/G1/.ssh/id_rsa", 
                             passphrase = rstudioapi::askForPassword())
url <- "git@gitlab1.economic.research:r-tools/importhaver.git"
devtools::install_git(url, credentials = creds)
```