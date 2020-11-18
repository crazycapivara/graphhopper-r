# x start point (lat, lng) pair
# y data frame with end points
# coords coord columns (lat, lng) in y
gh_get_route_table <- function(x, y, coords = c("lat", "lng")) {
  start_point <- x
  apply(y, 1, function(.x) {
    points <- list(x, unname(.x[coords]))
    r <- gh_get_route(points, calc_points = FALSE)
    path <- r$paths[[1]]
    list(time = path$time, distance = path$distance)
  }) %>% dplyr::bind_rows()
}
