context("route")

test_that("extract instructions", {
  # Prepare
  route <- readRDS("data/route-data.rds")

  # Act
  instructions <- gh_instructions(route)

  # Assert
  expect_is(instructions, "data.frame")
  expect_true(all(c("start_id", "end_id", "text") %in% names(instructions)))
})
