context("route")

utils_get_points <- function() {
  start_point <- c(52.592204, 13.414307)
  end_point <- c(52.539614, 13.364868)
  list(start_point, end_point)
}

test_that("route structure", {
  skip_on_cran()
  skip_on_travis()

  # Prepare
  points <- utils_get_points()

  # Act
  route <- gh_get_route(points)
  path <- route$paths[[1]]

  # Assert
  expect_is(route, "list")
  expect_true(path$points_encoded)
})
