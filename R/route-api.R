#' Get the route for a given set of points.
#' @param points list of points as [lat, lng] pairs
#' @param ... additional query parameters, see \url{https://docs.graphhopper.com}
#' @param sf whether to return route also as \code{sf} object
#' @examples \dontrun{
#'    start_point <- c(52.592204, 13.414307)
#'    end_point <- c(52.539614, 13.364868)
#'
#'    route_get(list(start_point, end_point), locale = "de")
#' }
#' @export
route_get <- function(points, ..., sf = TRUE) {
  route_get_raw(points, ...) %>%
    make_route_path(sf = sf)
}

route_get_raw <- function(points, ...) {
  query <- route_build_query(points, ...)
  route_response <- httr::GET(get_api_url(), path = "route", query = query)
  if (route_response$status != 200) {
    message("Something went wrong.")
    return(route_response)
  }

  httr::content(route_response)
}

route_build_query <- function(points, ...) {
  points <- lapply(points, point_str)
  names(points) <- rep("point", length(points))
  c(
    points,
    points_encoded = FALSE,
    ...
  )
}
