#' Get information about the GraphHopper instance
#' @example examples/api-reference/gh-get-info.R
#' @export
gh_get_info <- function() {
  httr::GET(get_api_url(), path = ENDPOINTS$info) %>%
    httr::content() %>%
    set_gh_class("gh_info")
}
