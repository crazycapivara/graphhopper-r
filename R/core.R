#' Set gh API base url
#' @note Internally it calls \code{Sys.setenv} to store the API url
#'   in an environment variable called \code{GH_API_URL}.
#' @param api_url API base url
#' @examples
#' gh_set_api_url("http://localhost:8989")
#' @export
gh_set_api_url <- function(api_url) {
  Sys.setenv(GH_API_URL = api_url)
}

gh_GET <- function(path, query = list(), ...) {
  if (is.null(query$key)) query$key <- Sys.getenv(GH_API_KEY)
  httr::GET(build_api_url(path), query = query, ...)
}

get_api_url <- function() {
  api_url <- Sys.getenv("GH_API_URL")
  ifelse(identical(api_url, ""), DEFAULT_API_URL, api_url)
}

build_api_url <- function(path) {
  sub("/$", "", get_api_url()) %>%
    paste0("/", path)
}

gh_is_avialable <- function() {
  tryCatch({
    httr::GET(get_api_url())
    invisible(TRUE)
    },
    error = function(e) {
      message(e$message)
      invisible(FALSE)
    }
  )
}
