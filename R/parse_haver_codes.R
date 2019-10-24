#' This function parses haver codes of the format
#' code{SERIES@DATABASE} and converts them to the format \code{database:series}
#'
#' @param series A series name to parse into the proper format
#' @return A character vector of Haver codes in the format "database:series"
#' @export
#' @examples
#' parse_haver_codes("GDP@USECON")
parse_haver_codes <- function(series) {
  parser <- function(series) {

    ## check inputs
    assertthat::assert_that(is.character(series))

    assertthat::assert_that(all(stringr::str_detect(series, "(@|:)")),
      msg = "No series/database separator"
    )
    assertthat::assert_that(all(stringr::str_count(series, "(@|:)") == 1),
      msg = "multiple separators detected"
    )

    if (stringr::str_detect(series, "@")) {
      s_1 <- stringr::str_to_lower(series)
      s_2 <- stringr::str_split(s_1, "@")
      s_3 <- s_2[[1]]

      assertthat::assert_that(length(s_3) == 2)

      out_series <- stringr::str_c(s_3[[2]], ":", s_3[[1]])

      return(out_series)
    } else if (stringr::str_detect(series, ":")) {
      out_series <- stringr::str_to_lower(series)
      return(out_series)
    }
  }

  parser <- Vectorize(parser, USE.NAMES = FALSE)
  parser(series)
}
