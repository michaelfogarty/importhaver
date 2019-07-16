#' Wrapper function around \code{Haver::haver.data} that returns a tibble with the dates in Date format and each series as a column.
#' 
#' @param series The series (in database:series or SERIES@DATABASE format) that you wish to pull from Haver.
#' @param ... Additional arguments to be passed to `haver.data`.
#' @return A \code{tibble} with a date column and a column for each series.
#' @export
#' @examples
#' import_haver(c('usecon:gdp', 'usecon:c'))


## import_haver.R
## Author: Michael Fogarty
## Crated: 7/12/19
## Last Major Revision: 7/15/19
## R Version 3.5.3

## This function is a wrapper around Haver's `haver.data` function that extracts
## the data into a tibble/data frame and converts the date row label into a
## date variable column

## TODO: explore mixed frequency series
## TODO: parse SERIES@DATABASE into database:series format

import_haver <- function(series, ...) {
  
  ## require namespace magrittr for the pipe operator
  requireNamespace('magrittr')
  
  ## check inputs
  assertthat::assert_that(is.character(series))
  
  
  ## convert haver code format if necessary
  
  series <- importhaver::parse_haver_codes(series)
  
  ## pull in data from haver
  Haver::haver.path('auto')
  dat <- Haver::haver.data(series, ...)

  ## check attributes of haver.data object
  assertthat::has_attr(dat, 'frequency')
  assertthat::has_attr(dat, 'metadata')
  assertthat::has_attr(dat, 'dimnames')
 
  ## pull useful info from the haver object:
  ## frequency, 
  freq <- attr(dat, 'frequency')
  
  ## extract data from atomic vector/matrix into a tibble
  
  dat <- tibble::as_tibble(dat, rownames = 'date')
  
  assertthat::assert_that(is.character(dat$date))
  
  ## convert character date column into a date type based on freq
  
  assertthat::assert_that(freq %in% c('annual', 'quarterly', 'monthly', 
                                      'weekly', 'daily'))
  
  if (freq == 'quarterly') {
      dat %>% dplyr::mutate(date = lubridate::yq(date))
  } else if (freq == 'monthly') {
      dat %>% dplyr::mutate(date = lubridate::ymd(paste0(date, '-01')))
  } else if (freq == 'annual') {
      dat %>% dplyr::mutate(date = lubridate::ymd(paste0(date, '-1-01')))
  } else {
      dat %>% dplyr::mutate(date = lubridate::ymd(date))
  }
  
}
