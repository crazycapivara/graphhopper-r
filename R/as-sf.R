gh_as_sf <- function(content) {
  path <- content$paths[[1]]
  coords_df <- googlePolylines::decode(path$points)[[1]][, c("lon", "lat")]
  line_sfc <- as.matrix(coords_df) %>%
    sf::st_linestring() %>%
    sf::st_sfc(crs = 4326)
  sf::st_sf(
    geometry = line_sfc,
    time = path$time,
    distance = path$distance
  )
}
