point_str <- function(point) {
  paste0(point, collapse = ",")
}

# TODO: obsolete
parse_lnglat_to_query_point <- function(lnglat) {
  paste0(lnglat, collapse = ",")
}
