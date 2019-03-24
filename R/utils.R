point_str <- function(point) {
  paste0(point, collapse = ",")
}

toJSON_fromJSON <- function(item) {
  jsonlite::toJSON(item, auto_unbox = TRUE) %>%
    jsonlite::fromJSON()
}

# TODO: obsolete
parse_lnglat_to_query_point <- function(lnglat) {
  paste0(lnglat, collapse = ",")
}
