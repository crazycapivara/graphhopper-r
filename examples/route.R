library(graphhopper)

start_point <- c(52.592204, 13.414307)
end_point <- c(52.539614, 13.364868)

route <- gh_get_route(list(start_point, end_point)) %>%
  gh_as_sf()

bbox <- sf::st_bbox(route)

map <- ggmap::get_stamenmap(unname(bbox), maptype = "terrain", urlonly = F, zoom = 14)

sf::st_geometry(route) %>%
  sf::st_transform(3857) %>%
  plot(bgMap = map, col = "red")


#ggmap(map) +
ggplot2::ggplot() +
  ggplot2::theme_void() +
  ggimage(map) +
  ggplot2::geom_sf(data = sf::st_transform(route, 3857))
