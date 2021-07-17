#' Get information about the GraphHopper instance
#' @example examples/api-reference/gh-get-info.R
#' @export
gh_get_info <- function() {
  gh_GET(ENDPOINTS$info) %>%
    httr::content() %>%
    set_gh_class("gh_info")
}
