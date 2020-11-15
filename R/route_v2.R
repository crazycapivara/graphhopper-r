gh_get_route_v2 <- function(points, ...) {
  points <- lapply(points, as_point_str)
  names(points) <- rep("point", length(points))
  query <- c(points, ...)
  httr::GET(get_api_url(), path = "route", query = query) %>%
    httr::content()
}
