#' @export
gh_get_route <- function(points, ..., points_encoded = TRUE, response_only = FALSE) {
  points <- lapply(points, as_point_str)
  names(points) <- rep("point", length(points))
  query <- c(points, points_encoded = points_encoded, ...)
  response <- httr::GET(get_api_url(), path = "route", query = query)
  if (response_only) return(response)

  httr::content(response)
}
