#' Get isochrones for a given start point
#' @inheritParams gh_get_spt
#' @param ... Additonal parameters.
#'   See \url{https://docs.graphhopper.com/#operation/getIsochrone}.
#' @example examples/api-reference/gh-get-isochrone.R
#' @export
gh_get_isochrone <- function(start_point, time_limit = 180, distance_limit = -1, ...) {
  query <- list(
    point = as_point_str(start_point),
    time_limit = time_limit,
    distance_limit = distance_limit,
    ...
  )
  response <- httr::GET(get_api_url(), path = ENDPOINTS$isochrone, query = query)
  httr::content(response) %>%
    set_gh_class("gh_isochrone")
}

#' @name gh_as_sf
#' @export
gh_as_sf.gh_isochrone <- function(data, ...) {
  jsonlite::toJSON(data$polygons, auto_unbox = TRUE) %>%
    geojsonsf::geojson_sf()
}

# Helper, unused, maybe it's faster than the approach above.
build_polygon_sf <- function(polygon) {
  unlist(polygon$geometry$coordinates) %>%
    matrix(ncol = 2, byrow = TRUE) %>%
    list() %>%
    sf::st_polygon() %>%
    sf::st_sfc(crs = 4326) %>%
    sf::st_sf()
}
