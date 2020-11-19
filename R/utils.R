point_str <- function(point) {
  .Deprecated("as_point_str")
  paste0(point, collapse = ",")
}

as_point_str <- function(point) {
  paste0(point, collapse = ",")
}

set_gh_class <- function(x, class_name = c("gh_route", "gh_spt", "gh_info")) {
  structure(x, class = c(class(x), match.arg(class_name)))
}

#toJSON_fromJSON <- function(item) {
#  jsonlite::toJSON(item, auto_unbox = TRUE) %>%
#    jsonlite::fromJSON()
#}

#toJSON_st_read <- function(item) {
#  jsonlite::toJSON(item, auto_unbox = TRUE) %>%
#    sf::st_read(quiet = TRUE)
#}

is_request_error <- function(response) {
  if (response$status != 200) {
    warning("Something went wrong. Returning (raw) response object.")
    return(TRUE)
  }

  FALSE
}
