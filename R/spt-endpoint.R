#' Get the shortest path tree for a given start point
#' @param start_point The start point as (lon, lat) pair.
#' @param time_limit The travel time limit in seconds.
#' @param columns The columns that should be returned.
#' @export
gh_get_spt <- function(start_point, time_limit = 600,
                    columns = c("longitude", "latitude", "time", "distance", "prev_longitude", "prev_latitude")) {
  query <-list(
    point = as_point_str(start_point),
    time_limit = time_limit,
    columns = paste0(columns, collapse = ",")
  )
  response <- httr::GET(get_api_url(), path = ENDPOINTS$spt, query = query)
  suppressWarnings(
    suppressMessages(httr::content(response)) %>%
      apply(2, as.double) %>% tibble::as_tibble() %>%
      set_gh_class("gh_spt")
  )
}

#"?point=", START_POINT$lat, ",", START_POINT$lng,
#"&time_limit=", TIME_LIMT,
#"&columns=prev_longitude,prev_latitude,longitude,latitude,time"
