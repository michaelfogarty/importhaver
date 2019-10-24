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
creds <- git2r::cred_ssh_key(private = "C:/Users/<your-g1-here>/.ssh/id_rsa", 
                             passphrase = rstudioapi::askForPassword())
url <- "git@gitlab1.economic.research:r-tools/importhaver.git"
devtools::install_git(url, credentials = creds)
```

Alternatively, you can use username/password authentication (I'm currently
having issues with the SSH version)

```r
creds <- git2r::cred_user_pass(rstudioapi::askForPassword("username"),
                               rstudioapi::askForPassword("Password"))
devtools::install_git(
    "https://gitlab1.economic.research/r-tools/importhaver.git",
    credentials = creds,
    upgrade = FALSE)
```