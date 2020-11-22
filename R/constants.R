DEFAULT_API_URL <- "http://localhost:8989"

ENDPOINTS <- list(
  route = "route",
  spt = "spt",
  info = "info",
  isochrone = "isochrone"
)

AVAILABLE_SPT_COLUMNS <- c(
  "node_id", "prev_node_id",
  "edge_id", "prev_edge_id",
  "longitude", "latitude", "time", "distance",
  "prev_longitude", "prev_latitude", "prev_time", "prev_distance"
)

SPT_COORD_COLUMNS <- c(
  "prev_longitude", "prev_latitude",
  "longitude", "latitude"
)
