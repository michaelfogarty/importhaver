#' Wrapper function around \code{Haver::haver.data} that returns a tibble with the dates in Date format and each series as a column.
#' 
#' @param series The series (in database:series or SERIES@DATABASE format) that you wish to pull from Haver.
#' @return A character vector of Haver codes in the format database:
#' @export
#' @examples
#' parse_haver_codes('GDP@USECON')

## parse_haver_codes.R
## Author: Michael Fogarty
## Crated: 7/15/19
## Last Major Revision: 7/15/19
## R Version 3.5.3

## This function parses haver codes of the format `SERIES@DATABASE` and converts
## them to the format `database:series` for use in the `Haver::haver.data` 
## function.

parse_haver_codes <- function(series){
  
  ## require namespace magrittr for the pipe operator
  requireNamespace('magrittr')
  
  parser <- function(series) {
    
    ## check inputs
    assertthat::assert_that(is.character(series))
    
    #
    assertthat::assert_that(all(stringr::str_detect(series, '(@|:)')),
                            msg = 'No series/database separator')
    assertthat::assert_that(all(stringr::str_count(series, '(@|:)') == 1),
                            msg = 'multiple separators detected')
    
    if (stringr::str_detect(series, '@')) {
      
      s_1 <- 
        series %>% 
        stringr::str_to_lower() %>% 
        stringr::str_split('@') %>% 
        magrittr::extract2(1)
      
      assertthat::assert_that(length(s_1) == 2)
      
      series <- stringr::str_c(s_1[2], ':', s_1[1])
      
      return(series)  
      
    } else if (stringr::str_detect(series, ':')) {
      series %>% 
        stringr::str_to_lower()
    }
  }
  
  purrr::map_chr(series, parser)
}


