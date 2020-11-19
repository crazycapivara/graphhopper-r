
# x start point (lat, lng) pair
# y data frame with end points
# coords coord columns (lat, lng) in y

#' Get multiple routes
#'
#' Internally it just calls \link{gh_get_route} sevaral times.
#' @param x A single start point as (lat, lon) pair
#' @param y A matrix or a data frame containing columns with latitudes and longitudes
#'   that are used as endpoints. Needs (lat, lon) order.
#' @param ... Parameters that are passed to \link{gh_get_route}.
#' @param callback A callback function that is applied to every calculated route.
#' @example examples/multiple-routes.R
#' @export
gh_get_routes <- function(x, y, ..., callback = NULL) {
  start_point <- x
  apply(y, 1, function(.x) {
    points <- list(start_point, unname(.x))
    r <- gh_get_route(points, ...)
    if (!is.null(callback)) return(callback(r))

    r
  })
}
