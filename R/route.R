get_route_response <- function(from_lnglat, to_lnglat, ...) {
  get <- gh_get("route")
  get(
    point = parse_lnglat_to_query_point(from_lnglat),
    point = parse_lnglat_to_query_point(to_lnglat),
    points_encoded = FALSE,
    ...
  )
}

# TODO: merge somehow with 'gh_route_coordinates'
parse_route <- function(route) {
  path <- route$paths[[1]]
  # coordinates <- unlist(path$points$coordinates) %>%
  #   matrix(ncol = 2, byrow = TRUE)
  # colnames(coordinates) <- c("lng", "lat")
  list(
    # coordinates = coordinates,
    coordinates = gh_route_coordinates(route),
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
  get_route(from_lnglat, to_lnglat, ...) %>%
    gh_route_line_sf()
  # route <- get_route(from_lnglat, to_lnglat, ...) %>%
  #   parse_route()
  # sf::st_linestring(route$coordinates) %>%
  #   sf::st_sfc(crs = 4326) %>%
  #  sf::st_sf(time = route$time, distance = route$distance, geometry = .)
}

# ### Extract stuff ###
gh_route_coordinates <- function(route) {
  path <- route$paths[[1]]
  coordinates <- unlist(path$points$coordinates) %>%
    matrix(ncol = 2, byrow = TRUE)
  colnames(coordinates) <- c("lng", "lat")
  coordinates
}

gh_route_points_sf <- function(route) {
  gh_route_coordinates(route) %>%
    as.data.frame() %>%
    sf::st_as_sf(coords = c("lng", "lat"), crs = 4326)
}

gh_route_line_sf <- function(route) {
  path <- route$paths[[1]]
  gh_route_coordinates(route) %>%
    sf::st_linestring() %>%
    sf::st_sfc(crs = 4326) %>%
    sf::st_sf(time = path$time, distance = path$distance, geometry = .)
}

gh_route_instructions <- function(route) {
  message("not implemented yet")
}
