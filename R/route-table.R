gh_callback_time_distance <- function(route) {
  path <- route$paths[[1]]
  list(time = path$time, distance = path$distance)
}

# x start point (lat, lng) pair
# y data frame with end points
# coords coord columns (lat, lng) in y
gh_get_routes <- function(x, y, coords = c("lat", "lng"), ..., callback = NULL) {
  start_point <- x
  apply(y, 1, function(.x) {
    points <- list(start_point, unname(.x[coords]))
    r <- gh_get_route(points, ...)
    if (!is.null(callback)) return(callback(r))

    r
    #r <- gh_get_route(points, calc_points = FALSE)
    #path <- r$paths[[1]]
    #list(time = path$time, distance = path$distance)
  }) #%>% dplyr::bind_rows()
}
