library(graphhopper)

start_point <- c(52.59220, 13.41431)
end_point <- c(52.53961, 13.36487)

route <- gh_get_route(list(start_point, end_point))

instructions_sf <- gh_as_sf(route, geom_type = "point") %>%
  dplyr::inner_join(gh_instructions(route), by = c(gh_id = "start_id"))

library(leaflet)

leaflet() %>%
  addTiles() %>%
  addPolylines(data = gh_as_sf(route)) %>%
  addCircleMarkers(data = instructions_sf, radius = 5, fillColor = "red", popup = ~text)
