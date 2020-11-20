# https://github.com/graphhopper/graphhopper/blob/master/web-bundle/src/main/java/com/graphhopper/resources/SPTResource.java

#' Get the shortest path tree for a given start point
#' @param start_point The start point as (lat, lon) pair.
#' @param time_limit The travel time limit in seconds.
#'   Ignored if \code{distance_limit > 0}.
#' @param distance_limit The distance limit in meters.
#' @param columns The columns to be returned. See \link{gh_spt_columns} and
#'   \link{gh_available_spt_columns} for available columns.
#' @param reverse_flow Use \code{reverse_flow = TRUE} to change the flow direction.
#' @param profile The profile for which the spt should be calculated.
#' @example examples/api-reference/gh-get-spt.R
#' @export
gh_get_spt <- function(start_point, time_limit = 600,
                       distance_limit = -1,
                       columns = gh_spt_columns(),
                       reverse_flow = FALSE, profile = "car") {
  query <-list(
    point = as_point_str(start_point),
    time_limit = time_limit,
    distance_limit = distance_limit,
    columns = paste0(columns, collapse = ","),
    reverse_flow = reverse_flow,
    profile = profile
  )
  response <- httr::GET(get_api_url(), path = ENDPOINTS$spt, query = query)
  if (is_request_error(response)) return(response)

  suppressWarnings(
    suppressMessages(httr::content(response)) %>%
      apply(2, as.double) %>% tibble::as_tibble() %>%
      set_gh_class("gh_spt")
  )
}

#' Get a vector with available columns of the spt endpoint
#' @export
gh_available_spt_columns <- function() AVAILABLE_SPT_COLUMNS

#' Select the columns to be returned by a spt request
#'
#' Times are returned in milliseconds and distances in meters.
#' @param longitude,latitude The longitude, latitude of the node.
#' @param time,distance The travel time, distance to the node.
#' @param prev_longitude,prev_latitude The longitude, latitude of the previous node.
#' @param prev_time,prev_distance The travel time, distance to the previous node.
#' @param node_id,prev_node_id The ID of the node, previous node.
#' @param edge_id,prev_edge_id The ID of the edge, previous edge.
#' @export
gh_spt_columns <- function(longitude = TRUE, latitude = TRUE,
                           time = TRUE, distance = TRUE,
                           prev_longitude = FALSE, prev_latitude = FALSE,
                           prev_time = FALSE, prev_distance = FALSE,
                           node_id = FALSE, prev_node_id = FALSE,
                           edge_id = FALSE, prev_edge_id = FALSE) {
  columns <- unlist(as.list(environment()))
  names(columns)[which(columns)]
}

#' Build lines from a gh spt object
#' @param data A \code{gh_spt} object.
#' @example examples/api-reference/gh-get-spt-lines.R
#' @export
gh_spt_as_linestrings_sf <- function(data) {
  data <- data[!is.na(data$prev_longitude), ]
  lines_sf <- lapply(1:nrow(data), function(i) build_linestring(data[i, SPT_COORD_COLUMNS])) %>%
    sf::st_sfc(crs = 4326) %>%
    sf::st_sf()
  dplyr::bind_cols(
    lines_sf,
    data[, -which(names(data) %in% SPT_COORD_COLUMNS)]
  )
}

# Utils
build_linestring <- function(row) {
  matrix(unlist(row), ncol = 2, byrow = TRUE) %>%
    sf::st_linestring()
}

#"?point=", START_POINT$lat, ",", START_POINT$lng,
#"&time_limit=", TIME_LIMT,
#"&columns=prev_longitude,prev_latitude,longitude,latitude,time"
