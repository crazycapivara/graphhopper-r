point_str <- function(point) {
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

# TODO: obsolete
parse_lnglat_to_query_point <- function(lnglat) {
  paste0(lnglat, collapse = ",")
}
