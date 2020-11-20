\dontrun{
start_point <- c(52.53961, 13.36487)

columns <- gh_spt_columns(
  prev_longitude = TRUE,
  prev_latitude = TRUE,
  prev_time = TRUE
)

points_sf <- gh_get_spt(start_point, time_limit = 180, columns = columns) %>%
  gh_as_sf()
}
