context("as sf")

test_that("route as sf linestring", {
  # Prepare
  route <- readRDS("data/route-data.rds")

  # Act
  route_sf <- gh_as_sf(route)

  # Assert
  expect_is(route_sf, "sf")
  expect_is(route_sf$geometry, "sfc_LINESTRING")
})

test_that("spt as sf points", {
  # Prepare
  spt <- readRDS("data/spt-data.rds")

  # Act
  spt_sf <- gh_as_sf(spt)

  # Assert
  expect_is(spt_sf, "sf")
  expect_is(spt_sf$geometry, "sfc_POINT")
})
