#\dontrun{
start_point <- c(52.519772, 13.392334)

end_points <- rbind(
  c(52.564665, 13.42083),
  c(52.564456, 13.342724),
  c(52.489261, 13.324871),
  c(52.48738, 13.454647)
)

time_distance_table <- gh_get_routes(
  start_point, end_points, calc_points = FALSE,
  callback = gh_time_distance
  ) %>%
  dplyr::bind_rows()

routes_sf <- gh_get_routes(start_point, end_points, callback = gh_as_sf) %>%
  do.call(rbind, .)

library(leaflet)

leaflet() %>%
  addProviderTiles(providers$Stamen.TonerBackground) %>%
  addPolylines(data = routes_sf, color = "red", weight = 2)
#}
