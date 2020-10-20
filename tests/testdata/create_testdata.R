# Create Test Data for import_haver
# Michael Fogarty, 2020

# Setup -------------------------------------------------------------------

start_date <- lubridate::ymd("2015-01-01")
end_date <- lubridate::ymd("2019-12-31")

# Annual Data -------------------------------------------------------------

annual_data_eop <- 
  import_haver(
    series = "GDPHA@USECON",
    eop = TRUE,
    start = start_date,
    end = end_date
  )

annual_data <-
  import_haver(
    series = "GDPHA@USECON",
    eop = FALSE,
    start = start_date,
    end = end_date
  )

write.csv(annual_data, file = "tests/testdata/annual_data.csv", row.names = FALSE)
write.csv(annual_data_eop, file = "tests/testdata/annual_data_eop.csv", row.names = FALSE)


# Quarterly Data ----------------------------------------------------------

quarterly_data_eop <- 
  import_haver(
    series = "GDPH@USECON",
    eop = TRUE,
    start = start_date,
    end = end_date
  )

quarterly_data <-
  import_haver(
    series = "GDPH@USECON",
    eop = FALSE,
    start = start_date,
    end = end_date
  )

write.csv(quarterly_data, file = "tests/testdata/quarterly_data.csv", row.names = FALSE)
write.csv(quarterly_data_eop, file = "tests/testdata/quarterly_data_eop.csv", row.names = FALSE)


# Monthly Data ------------------------------------------------------------

monthly_data_eop <- 
  import_haver(
    series = "LR@USECON",
    eop = TRUE,
    start = start_date,
    end = end_date
  )

monthly_data <-
  import_haver(
    series = "LR@USECON",
    eop = FALSE,
    start = start_date,
    end = end_date
  )

write.csv(monthly_data, file = "tests/testdata/monthly_data.csv", row.names = FALSE)
write.csv(monthly_data_eop, file = "tests/testdata/monthly_data_eop.csv", row.names = FALSE)


# Weekly Data -------------------------------------------------------------

weekly_data <-
  import_haver(series = "FFED@WEEKLY", start = start_date, end = end_date)

write.csv(weekly_data, file = "tests/testdata/weekly_data.csv", row.names = FALSE)

# Daily Data --------------------------------------------------------------

daily_data <-
  import_haver(series = "FFED@DAILY", start = start_date, end = end_date)

write.csv(daily_data, file = "tests/testdata/daily_data.csv", row.names = FALSE)


# Variable Names from Named Vector ----------------------------------------

names_all <-
  import_haver(
    series = c(hours = "LITPRIVA@USECON", payroll = "LGTPRIVA@USECON"),
    start = start_date, end = end_date
  )

write.csv(names_all, file = "tests/testdata/names_all.csv", row.names = FALSE)

names_some <-
  import_haver(
    series = c(hours = "LITPRIVA@USECON","LGTPRIVA@USECON"),
    start = start_date, end = end_date
  )

write.csv(names_some, file = "tests/testdata/names_some.csv", row.names = FALSE)
