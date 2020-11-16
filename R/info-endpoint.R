#' @export
gh_get_info <- function() {
  httr::GET(get_api_url(), path = ENDPOINTS$info) %>%
    httr::content() %>%
    set_gh_class("gh_info")
}
