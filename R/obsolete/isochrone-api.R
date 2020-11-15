#' Get the isochrones for a given point.
#' @inheritParams route_get
#' @param point numeric vector; [lat, lng] pair
#' @export
isochrone_get <- function(api_client, point, ...) {
  isochrone_get_raw(api_client, point, ...) %>%
    make_isochrone()
}

isochrone_get_raw <- function(api_client, point, ...) {
  query <- isochrone_build_query(point, ...)
  api_client("isochrone", query) %>%
    check_response()
}

isochrone_build_query <- function(point, ...) {
  list(
    point = point_str(point),
    ...
  )
}
