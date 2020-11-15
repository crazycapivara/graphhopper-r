#' @export
gh_get_spt <- function(start_point, time_limit = 600,
                    columns = c("longitude", "latitude", "time")) {
  query <-list(
    point = as_point_str(start_point),
    time_limit = time_limit,
    columns = paste0(columns, collapse = ",")
  )
  response <- httr::GET(get_api_url(), path = "spt", query = query)
  suppressMessages(httr::content(response))
}

#"?point=", START_POINT$lat, ",", START_POINT$lng,
#"&time_limit=", TIME_LIMT,
#"&columns=prev_longitude,prev_latitude,longitude,latitude,time"
