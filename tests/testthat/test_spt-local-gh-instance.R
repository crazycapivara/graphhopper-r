context("spt")

test_that("spt endpoint", {
  skip_if_not(gh_is_avialable())
  skip_on_cran()
  skip_on_travis()

  # Prepare
  start_point <- c(52.592204, 13.414307)
  time_limit <- 120
  custom_columns <- gh_spt_columns(
    prev_longitude = TRUE,
    prev_latitude = TRUE,
    prev_time = TRUE
  )

  # Act
  spt_df <- gh_get_spt(start_point, time_limit = time_limit)
  spt_custom_df <- gh_get_spt(start_point, time_limit = time_limit,
                              columns = custom_columns)

  # Assert
  expected_default_columns <- c("longitude", "latitude", "time", "distance")
  expect_is(spt_df, "data.frame")
  expect_equal(names(spt_df), expected_default_columns)
  expect_equal(names(spt_custom_df), custom_columns)
})
