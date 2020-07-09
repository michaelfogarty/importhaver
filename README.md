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

To install the package from Gitlab, use the `install_gitlab` function from the
`devtools` package. You will also need to create a personal access token on Gitlab.

```r
options("download.file.method"='libcurl')
devtools::install_gitlab(
  repo = "r-tools/importhaver",
  auth_token = keyring::key_get("gitlab-token"),
  host = "gitlab1.economic.research",
  quiet = FALSE,
  force = TRUE
)
```

See the accepted answer [here](https://stackoverflow.com/questions/59838094/installing-a-package-from-private-gitlab-server-on-windows)
 for more information.

#### Gitlab Personal Access Token

To install the package from gitlab, you need to create a personal access token. Navigate to [https://gitlab1.economic.research/profile/personal_access_tokens](https://gitlab1.economic.research/profile/personal_access_tokens) 
and create a token with api access. Leaving the date field blank makes sure it does not expire. 

I recommend using the `keyring` package to securly store your personal access 
token in the system credential manager. To save the token, run the following line of code:

```r
keyring::key_set(service = "gitlab-token")
```
You will then be prompted to paste in the token string.