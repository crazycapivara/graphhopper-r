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
