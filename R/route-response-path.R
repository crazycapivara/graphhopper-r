# TODO:
# * Add helper toJSON -> fromJSON
# * Add helper parsing coordinates: 'response_coordinates'
# * Add helper GeoJSON -> sf: 'response_geojson'
# -----

route_response_path <- function(route_response, sf = TRUE) {
  path <- route_response$paths[[1]]
  result <- list(
    time = path$time,
    distance = path$distance,
    weight = path$weight,
    instructions = route_response_path_instructions(path),
    points = route_response_path_points_coordinates(path),
    snapped_waypoints = route_response_path_snapped_waypoints_coordinates(path)
  )
  if (sf) result$linestring <- route_response_path_points_linestring(path)

  result
}

route_response_path_points_coordinates <- function(path) {
  coords <- path$points$coordinates %>%
    jsonlite::toJSON(auto_unbox = TRUE) %>%
    jsonlite::fromJSON()
  if (ncol(coords) == 3) colnames(coords) <- c("x", "y", "z")
  else colnames(coords) <- c("x", "y")

  coords %>% tibble::as_tibble()
}

route_response_path_points_linestring <- function(path) {
  linestring <- jsonlite::toJSON(path$points, auto_unbox = TRUE) %>%
    sf::st_read(quiet = TRUE)
  linestring$time <- path$time
  linestring$distance <- path$distance
  linestring
}

route_response_path_snapped_waypoints_coordinates <- function(path) {
  coords <- path$snapped_waypoints$coordinates %>%
    jsonlite::toJSON(auto_unbox = TRUE) %>%
    jsonlite::fromJSON()
  colnames(coords) <- c("x", "y")
  coords %>% tibble::as_tibble()
}

route_response_path_instructions <- function(path) {
  if (is.null(path$instructions)) return(NULL)

  jsonlite::toJSON(path$instructions, auto_unbox = TRUE) %>%
    jsonlite::fromJSON() %>%
    tibble::as_tibble()
}
