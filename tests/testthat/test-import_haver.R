test_that("Annual data pulls properly", {
  
  start_date <- lubridate::ymd("2015-01-01")
  end_date <- lubridate::ymd("2019-12-31")
  
  
  # Create test datasets
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
  
  # Test equivalence
  expect_equal(annual_data_eop,
    read.csv("../testdata/annual_data_eop.csv", colClasses = c("Date", "double")))
  expect_equal(annual_data,
    read.csv("../testdata/annual_data.csv", colClasses = c("Date", "double")))
})

test_that("Quarterly data pulls properly", {
  
  start_date <- lubridate::ymd("2015-01-01")
  end_date <- lubridate::ymd("2019-12-31")
  
  
  # Create test datasets
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
  
  # Test equivalence
  expect_equal(quarterly_data_eop,
    read.csv("../testdata/quarterly_data_eop.csv", colClasses = c("Date", "double")))
  expect_equal(quarterly_data,
    read.csv("../testdata/quarterly_data.csv", colClasses = c("Date", "double")))
})

test_that("Monthly data pulls properly", {
  
  start_date <- lubridate::ymd("2015-01-01")
  end_date <- lubridate::ymd("2019-12-31")
  
  
  # Create test datasets
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
  
  # Test equivalence
  expect_equal(monthly_data_eop,
    read.csv("../testdata/monthly_data_eop.csv", colClasses = c("Date", "double")))
  expect_equal(monthly_data,
    read.csv("../testdata/monthly_data.csv", colClasses = c("Date", "double")))
})

test_that("Weekly data pulls properly", {
  
  start_date <- lubridate::ymd("2015-01-01")
  end_date <- lubridate::ymd("2019-12-31")
  
  # Create test dataset
  weekly_data <-
    import_haver(series = "FFED@WEEKLY", start = start_date, end = end_date)

  
  # Test equivalence
  expect_equal(weekly_data,
    read.csv("../testdata/weekly_data.csv", colClasses = c("Date", "double")))
})

test_that("Daily data pulls properly", {
  
  start_date <- lubridate::ymd("2015-01-01")
  end_date <- lubridate::ymd("2019-12-31")
  
  # Create test dataset
  daily_data <-
    import_haver(series = "FFED@DAILY", start = start_date, end = end_date)
  
  # Test equivalence
  expect_equal(daily_data,
    read.csv("../testdata/daily_data.csv", colClasses = c("Date", "double")))
})

test_that("Mixed frequencies fail", {
  expect_error(import_haver(series = c("LR@USECON", "FFED@WEEKLY")))
})

test_that("Setting variable names from named vector", {
  
  start_date <- lubridate::ymd("2015-01-01")
  end_date <- lubridate::ymd("2019-12-31")
  
  # Create test datasets
  names_all <-
    import_haver(
      series = c(hours = "LITPRIVA@USECON", payroll = "LGTPRIVA@USECON"),
      start = start_date, end = end_date
    )
  
  names_some <-
    import_haver(
      series = c(hours = "LITPRIVA@USECON","LGTPRIVA@USECON"),
      start = start_date, end = end_date
    )
  
  # Test equivalence
  expect_equal(
    names_all,
    read.csv("../testdata/names_all.csv", colClasses = c("Date", "double", "double"))
  )
  
  expect_equal(
    names_some,
    read.csv("../testdata/names_some.csv", colClasses = c("Date", "double", "double"))
  )
  
})
