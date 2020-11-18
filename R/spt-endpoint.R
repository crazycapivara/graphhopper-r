# https://github.com/graphhopper/graphhopper/blob/master/web-bundle/src/main/java/com/graphhopper/resources/SPTResource.java

#' Get the shortest path tree for a given start point
#' @param start_point The start point as (lon, lat) pair.
#' @param time_limit The travel time limit in seconds.
#'   Ignored if \code{distance_limit > 0}.
#' @param distance_limit The distance limit in meters.
#' @param columns The columns that should be returned.
#' @param reverse_flow Whether to change the flow direction.
#' @param profile The profile for which the spt should be calculated.
#' @param
#'   See \link{gh_available_spt_columns} for available columns.
#' @export
gh_get_spt <- function(start_point, time_limit = 600,
                       distance_limit = -1,
                       columns = c("longitude", "latitude", "time", "distance"),
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

gh_spt_columns <- function(longitude = TRUE, latitude = TRUE,
                           time = TRUE, distance = TRUE,
                           prev_longitude = FALSE, prev_latitude = FALSE,
                           prev_time = FALSE, prev_distance = FALSE,
                           node_id = FALSE, prev_node_id = FALSE,
                           edge_id = FALSE, prev_edge_id = FALSE) {
  columns <- sapply(ls(environment()), function(x) ifelse(get(x), x, NA)) %>%
    unname()
  columns[!is.na(columns)]
}

#' Build lines from gh spt opbject
#' @param data A \code{gh_spt} object.
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
