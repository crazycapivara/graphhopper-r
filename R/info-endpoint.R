#' Get information about the GraphHooper instance
#' @examples \dontrun{
#'   gh_get_info()$data_date
#'
#'   gh_get_info()$version
#'
#'   gh_get_info() %>%
#'     gh_bbox()
#' }
#' @export
gh_get_info <- function() {
  httr::GET(get_api_url(), path = ENDPOINTS$info) %>%
    httr::content() %>%
    set_gh_class("gh_info")
}
