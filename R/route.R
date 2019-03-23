#' @export
gh_get_route <- function(points, ...) {
  route_response <- gh_get_route_response(points, ...)
  if (route_response$status != 200) {
    return(route_response)
  }

  httr::content(route_response)
}

gh_get_route_response <- function(points, ...) {
  points <- lapply(points, point_str)
  names(points) <- rep("point", length(points))
  query <- c(
    points,
    points_encoded = FALSE,
    ...
  )
  httr::GET(get_api_url(), path = "route", query = query)
}

#' @export
gh_route_linestring <- function(route) {
  route <- gh_parse_route(route)
  route_linestring <- sf::st_linestring(route$coordinates) %>%
    sf::st_sfc(crs = 4326)
  sf::st_sf(
    geometry = route_linestring,
    time = route$time,
    distance = route$distance
  )
}

#' @export
gh_route_coordinates <- function(route) {
  route <- gh_parse_route(route)
  tibble::as_tibble(route$coordinates)
}

gh_parse_route <- function(route) {
  path <- route$paths[[1]]
  n <- length(path$points$coordinates[[1]])
  coordinates <- unlist(path$points$coordinates) %>%
    matrix(ncol = n, byrow = TRUE)
  colnames(coordinates) <- c("lng", "lat")
  list(
    coordinates = coordinates,
    time = path$time,
    distance = path$distance
  )
}
