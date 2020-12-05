if (FALSE) {
  start_point <- c(52.592204, 13.414307)
  end_point <- c(52.539614, 13.364868)

  route_sf <- gh_get_route(list(start_point, end_point)) %>%
    gh_as_sf()
}
