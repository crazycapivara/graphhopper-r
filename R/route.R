get_route_response <- function(from_lnglat, to_lnglat, ...) {
  get <- gh_get("route")
  get(
    point = parse_lnglat_to_query_point(from_lnglat),
    point = parse_lnglat_to_query_point(to_lnglat),
    points_encoded = FALSE,
    ...
  )
}

parse_route <- function(route) {
  path <- route$paths[[1]]
  coordinates <- unlist(path$points$coordinates) %>%
    matrix(ncol = 2, byrow = TRUE)
  colnames(coordinates) <- c("lng", "lat")
  list(
    coordinates = coordinates,
    time = path$time,
    distance = path$distance
  )
}

#' Get the route for a given start and end point.
#' @param from_lnglat numeric vector; coordinates [lng, lat] of start point
#' @param to_lnglat numeric vector; coordinates [lng, lat] of end point
#' @param ... additional query parameters
#' @export
get_route <- function(from_lnglat, to_lnglat, ...) {
  get_route_response(from_lnglat, to_lnglat) %>%
    httr::content()
}

#' Get the route for a given start and end point as \code{sf} object.
#' @inheritParams get_route
#' @export
get_route_sf <- function(from_lnglat, to_lnglat, ...) {
  route <- get_route(from_lnglat, to_lnglat, ...) %>%
    parse_route()
  sf::st_linestring(route$coordinates) %>%
    sf::st_sfc(crs = 4326) %>%
    sf::st_sf(time = route$time, distance = route$distance, geometry = .)
}
