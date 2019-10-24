#' Wrapper function around \code{Haver::haver.data} that returns a tibble with
#' the dates in Date format and each series as a column.
#'
#' @param series The series (in database:series or SERIES@DATABASE format) that
#' you wish to pull from Haver.
#' @param ... Additional arguments to be passed to \code{haver.data}.
#'
#' @return A \code{tibble} with a date column and a column for each series.
#'
#' @export
#'
#' @examples
#' import_haver(c('usecon:gdp', 'usecon:c'))

import_haver <- function(series, ...) {

  ## check inputs
  assertthat::assert_that(is.character(series))


  ## convert haver code format if necessary

  series <- importhaver::parse_haver_codes(series)

  ## pull in data from haver
  Haver::haver.path("auto")
  dat <- Haver::haver.data(series, ...)

  ## check attributes of haver.data object
  assertthat::has_attr(dat, "frequency")
  assertthat::has_attr(dat, "metadata")
  assertthat::has_attr(dat, "dimnames")

  ## pull useful info from the haver object:
  freq <- attr(dat, "frequency")

  ## extract data from atomic vector/matrix into a tibble
  dat <- tibble::as_tibble(dat, rownames = "date")
  assertthat::assert_that(is.character(dat$date))

  ## convert character date column into a date type based on freq
  assertthat::assert_that(freq %in% c("annual", "quarterly", "monthly",
                                      "weekly", "daily"))

  if (freq == "quarterly") {
    dplyr::mutate(dat, date = lubridate::yq(date))
  } else if (freq == "monthly") {
      dplyr::mutate(dat, date = lubridate::ymd(paste0(date, "-01")))
  } else if (freq == "annual") {
      dplyr::mutate(dat, date = lubridate::ymd(paste0(date, "-1-01")))
  } else {
      dplyr::mutate(dat, date = lubridate::ymd(date))
  }

}
