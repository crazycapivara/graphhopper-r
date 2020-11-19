#' API client
#' @param base_url character scalar; API base url
#' @param port numeric scalar; port
#' @export
api_client <- function(base_url = Sys.getenv("GH_API_URL"), port = NULL) {
  structure(
    function(path, query) {
      httr::GET(base_url, port = port, path = path, query = query)
    },
    class = "api_client"
  )
}
