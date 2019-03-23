context("route")

mock_httr_GET <- function(...) {
  readRDS("data/route-response.rds")
}

test_that("sf LINESTRING", {
  with_mock(`httr::GET` = mock_httr_GET, {
      # Prepare
      start_point <- c(52.592204, 13.414307)
      end_point <- c(52.539614, 13.364868)

      # Act
      route <- gh_get_route(list(start_point, end_point)) %>%
        gh_route_linestring()

      # Assert
      expect_equal(route$time, 712414)
      expect_is(route, "sf")
      expect_equal(colnames(route), c("time", "distance", "geometry"))
    })
})
