# ### TODO: obsolete file

#' Get the route for a given set of points.
#' @param points list of points as [lat, lng] pairs
#' @param ... additional query parameters, see \url{https://docs.graphhopper.com}
#' @examples \dontrun{
#'    start_point <- c(52.592204, 13.414307)
#'    end_point <- c(52.539614, 13.364868)
#'
#'    gh_get_route(list(start_point, end_point), locale = "de") %>%
#'      gh_route_linestring()
#' }
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

#' Parse route to linestring.
#' @param route (raw) route object, see \code{\link{gh_get_route}}
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

#' Get coordinates from route.
#' @inheritParams gh_route_linestring
#' @export
gh_route_coordinates <- function(route) {
  route <- gh_parse_route(route)
  tibble::as_tibble(route$coordinates)
}

# ### TODO: Do not export this one
#' Parse route.
#' @inheritParams gh_route_linestring
#' @export
gh_parse_route <- function(route) {
  path <- route$paths[[1]]
  n <- length(path$points$coordinates[[1]])
  coordinates <- unlist(path$points$coordinates) %>%
    matrix(ncol = n, byrow = TRUE)
  if (n == 3) {
    colnames(coordinates) <- c("lng", "lat", "alt")
  } else {
    colnames(coordinates) <- c("lng", "lat")
  }

  list(
    coordinates = coordinates,
    time = path$time,
    distance = path$distance
  )
}

gh_route_distance <- function(route) {
  route$path[[1]]$distance
}

gh_route_time <- function(route) {
  route$path[[1]]$time
}

gh_route_instructions <- function(route) {
  message("not implemented yet")
}
