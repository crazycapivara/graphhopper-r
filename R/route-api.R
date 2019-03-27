#' Get the route for a given set of points.
#' @param api_client api client, see \code{\link{api_client}}
#' @param points list of points as [lat, lng] pairs
#' @param ... additional query parameters, see \url{https://docs.graphhopper.com}
#' @param sf logical scalar; whether to return route also as \code{sf} object
#' @examples \dontrun{
#'    start_point <- c(52.592204, 13.414307)
#'    end_point <- c(52.539614, 13.364868)
#'
#'    route_get(list(start_point, end_point), locale = "de")
#' }
#' @export
route_get <- function(api_client, points, ..., sf = TRUE) {
  route_get_raw(api_client, points, ...) %>%
    make_route_path(sf = sf)
}

route_get_raw <- function(api_client, points, ...) {
  query <- route_build_query(points, ...)
  route_response <- api_client("route", query)
  # route_response <- httr::GET(get_api_url(), path = "route", query = query)
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
