context("route")

test_that("extract instructions", {
  # Prepare
  route <- readRDS("data/route-data.rds")

  # Act
  instructions <- gh_instructions(route, instructions_only = TRUE)

  # Assert
  expect_is(instructions, "data.frame")
  expect_true(all(c("gh_start_id", "gh_end_id", "text") %in% names(instructions)))
})
