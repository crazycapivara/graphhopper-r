#' Convert a gh object into an sf object
#' @param data A \code{gh_route} or \code{gh_spt} object.
#' @param ... ignored
#' @example examples/api-reference/gh-get-route.R
#' @export
gh_as_sf <- function(data, ...) {
  UseMethod("gh_as_sf", data)
}

#' @param geom_type Use \code{geom_type = point} to return the points of the route
#'   with ids corresponding to the instruction ids.
#' @name gh_as_sf
#' @export
gh_as_sf.gh_route <- function(data, ..., geom_type = c("linestring", "point")) {
  if (match.arg(geom_type) == "point") {
    return(sf::st_as_sf(gh_points(data), coords = c("lon", "lat"), crs = 4326))
  }

  path <- data$paths[[1]]
  coords_df <- googlePolylines::decode(path$points)[[1]][, c("lon", "lat")]
  line_sfc <- as.matrix(coords_df) %>%
    sf::st_linestring() %>%
    sf::st_sfc(crs = 4326)
  sf::st_sf(
    geometry = line_sfc,
    time = path$time,
    distance = path$distance
  )
}

#' @name gh_as_sf
#' @export
gh_as_sf.gh_spt <- function(data, ...) {
  data %>%
    sf::st_as_sf(coords = c("longitude", "latitude"), crs = 4326)
}
