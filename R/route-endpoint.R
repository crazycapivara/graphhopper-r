#' Get a route for a given set of points
#' @param points A list of 2 or more points as (lat, lon) pairs.
#' @param ... Optional parameters that are passed to the query.
#' @param response_only Whether to return the raw response object instead of
#'   just its content.
#' @seealso \url{https://docs.graphhopper.com/#tag/Routing-API} for optional parameters.
#' @example examples/api-reference/gh-get-route.R
#' @export
gh_get_route <- function(points, ..., response_only = FALSE) {
  points <- lapply(points, as_point_str)
  names(points) <- rep("point", length(points))
  query <- c(points, ...)
  response <- httr::GET(get_api_url(), path = ENDPOINTS$route, query = query)
  if (response_only) return(response)

  httr::content(response) %>%
    set_gh_class("gh_route")
}
