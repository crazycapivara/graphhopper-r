library(graphhopper)
library(ggplot2)

start_point <- c(52.53961, 13.36487)

points_sf <- gh_get_spt(start_point, time_limit = 180) %>%
  gh_as_sf() %>%
  dplyr::mutate(
    color = scales::col_bin("YlOrRd", time, bins = 3)(time),
    time = as.integer(time/1000/60)
  )

ggplot() +
  geom_sf(data = points_sf, aes(colour = time), size = 0.5) +
  theme_bw()

mapboxer(bounds = sf::st_bbox(points_sf)) %>%
  add_circle_layer(
    source = as_mapbox_source(points_sf)
    , circle_color = c("get", "color")
  )
