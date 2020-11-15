point_str <- function(point) {
  .Deprecated("as_point_str")
  paste0(point, collapse = ",")
}

as_point_str <- function(point) {
  paste0(point, collapse = ",")
}

toJSON_fromJSON <- function(item) {
  jsonlite::toJSON(item, auto_unbox = TRUE) %>%
    jsonlite::fromJSON()
}

toJSON_st_read <- function(item) {
  jsonlite::toJSON(item, auto_unbox = TRUE) %>%
    sf::st_read(quiet = TRUE)
}

check_response <- function(response) {
  if (response$status != 200) {
    message("Something went wrong.")
    return(response)
  }

  httr::content(response)
}
