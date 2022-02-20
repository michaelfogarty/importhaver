test_that("Single codes work", {
  expect_match(parse_haver_codes("GDP@USECON"), "usecon:gdp")
  expect_match(parse_haver_codes("gdp@usecon"), "usecon:gdp")
  expect_match(parse_haver_codes("USECON:GDP"), "usecon:gdp")
  expect_match(parse_haver_codes("usecon:gdp"), "usecon:gdp")
})

test_that("Multiple codes work", {
  expect_match(parse_haver_codes(c("GDP@USECON", "C@USECON")),
               regexp = "^[a-z]+:[a-z]+?")
})

test_that("Mismatched codes work", {
  expect_match(parse_haver_codes(c("GDP@USECON", "USECON:C")),
               regexp = "^[a-z]+:[a-z]+?")
})
