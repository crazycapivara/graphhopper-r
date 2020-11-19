make_route_path <- function(route_response, sf = TRUE) {
  path <- route_response$paths[[1]]
  result <- list(
    time = path$time,
    distance = path$distance,
    weight = path$weight,
    points = parse_coordinates(path$points$coordinates),
    snapped_waypoints = parse_coordinates(path$snapped_waypoints$coordinates),
    instructions = parse_instructions(path$instructions)
  )
  if (sf) {
    result$linestring_points <- route_to_sf(path)
    result$linestring_snapped_waypoints <- toJSON_st_read(path$snapped_waypoints)
  }

  result
}

parse_coordinates <- function(coordinates) {
  coords <- toJSON_fromJSON(coordinates)
  if (ncol(coords) == 3) colnames(coords) <- c("x", "y", "z")
  else colnames(coords) <- c("x", "y")

  tibble::as_tibble(coords)
}

route_to_sf <- function(path) {
  linestring <- toJSON_st_read(path$points)
  linestring$time <- path$time
  linestring$distance <- path$distance
  linestring
}

parse_instructions <- function(instructions) {
  if (is.null(instructions)) return(NULL)

  toJSON_fromJSON(instructions) %>%
    tibble::as_tibble()
}
