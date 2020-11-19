start_point <- c(52.592204, 13.414307)
end_point <- c(52.539614, 13.364868)

get_this <- gh_get("route")
r <- get_this()

.gh_get_route <- function(points, ...) {
  points <- lapply(points, point_str)
  names(points) <- rep("point", length(points))
  query <- c(points, ...)
  httr::GET(get_api_url(), path = "route", query = query)
}

r <- .gh_get_route(list(start_point, end_point), locale = "de") %>%
  httr::content()

r$paths[[1]]$points

coords <- googlePolylines::decode(r$paths[[1]]$points)[[1]][, c("lon", "lat")]
###

points <- lapply(points, point_str)
names(points) <- rep("point", length(points))
query <- c(
  points,
  points_encoded = FALSE,
  ...
)
httr::GET(get_api_url(), path = "route", query = query)
