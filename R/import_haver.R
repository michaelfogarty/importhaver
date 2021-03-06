#' Wrapper function around \code{Haver::haver.data} that returns a tibble with
#' the dates in Date format and each series as a column.
#'
#' @param series The series (in database:series or SERIES@DATABASE format) that
#' you wish to pull from Haver. Optionally, you can pass series names that
#' differ from the Haver mnemonics as names for the character vector for Haver 
#' codes.
#' @param eop Logical (TRUE/FALSE) whether to use end of period dates for annual,
#' quarterly, and monthly series. Defaults to TRUE.
#' @param ... Additional arguments to be passed to \code{haver.data}. The most 
#' useful are \code{start} and \code{end}.
#'
#' @return A \code{tibble} with a date column and a column for each series.
#'
#' @export
#'
#' @examples
#' import_haver(c("usecon:gdp", "usecon:c"))
import_haver <- function(series, eop = TRUE, ...) {

  ## check inputs
  assertthat::assert_that(is.character(series))
  assertthat::assert_that(is.logical(eop))

  ## convert haver code format if necessary
  names <- names(series)
  series <- importhaver::parse_haver_codes(series)
  
  # Check Haver directory existence
  assertthat::assert_that(dir.exists(Haver::haver.path()))
  
  # Get metadata
  metadata <- Haver::haver.metadata(series)
  
  # Error out if metadata query fails
  if ("HaverErrorReport" %in% class(metadata)) {
    
    bad_codes <- metadata[["codes.notfound"]]
    
    stop(paste("Haver query failed. The folowing codes could not be found:",
                bad_codes))
  }
  
  # series frequency
  freq <- metadata$frequency
  assertthat::assert_that(length(unique(freq)) == 1,
                          msg = "Series have multiple frequencies")
  
  freq <- unique(freq)
 
  ## pull in data from haver 
  if (freq %in% c("A", "Q", "M")) {
    haver_data <-
      Haver::haver.data(
        codes = series,
        limits = FALSE,
        eop.dates = eop,
        ...
      )
  } else if (freq %in% c("W", "D")) {
    haver_data <-
      Haver::haver.data(
        codes = series,
        limits = FALSE,
        ...
      )
  }
  
  ## extract data from HaverData into a tibble
  dat <- tibble::as_tibble(as.data.frame(haver_data), rownames = "date")
  assertthat::assert_that(is.character(dat$date))
  
  ## replace mnemonics with series names passed as a named vector
  if (!is.null(names)) {
    names <- c("date", names)
    names_clean <- make.names(names)
    # only replace names that are not blank
    colnames(dat)[!grepl(pattern = "^$", x =names)] <-
      names_clean[!grepl(pattern = "^$", x =names)]
  }

  # convert to date
  if (freq %in% c("W", "D") | eop) {
    dplyr::mutate(dat, date = lubridate::ymd(date))
  } else if (!eop & freq == "Q") {
    dplyr::mutate(dat, date = lubridate::yq(date))
  } else if (!eop & freq == "A") {
    dplyr::mutate(dat, date = lubridate::ymd(date, truncated = 2L))
  } else if (!eop & freq == "M") {
    dplyr::mutate(dat, date = lubridate::ymd(date, truncated = 1L))
  }

}
