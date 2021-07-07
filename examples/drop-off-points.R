library(tibble)
library(graphhopper)

# Setup

gh_set_api_url("http://localhost:8989")
gh_get_info()

# Create sample data

start_point <- c(52.519772, 13.392334)

drop_off_points <- rbind(
  c(52.564665, 13.42083),
  c(52.564456, 13.342724),
  c(52.489261, 13.324871),
  c(52.48738, 13.454647),
  c(52.48638, 13.484647)
) %>%
  as_tibble(.name_repair = ~c("lat", "lng")) %>%
  dplyr::mutate(booking_id = c(rep("aa", 3), rep("bb", 2)))

# Split drop off points by booking id

drop_off_points_splitted <- drop_off_points %>%
  dplyr::group_split(booking_id)

# Add helper to extract points for a single booking id
# from tibble (data.frame), so that it can be used as input
# for 'gh_get_route'

get_route_points <- function(x, start_point) {
  via_points <- purrr::pmap(x, function(lat, lng, booking_id) c(lat, lng))
  c(list(start_point), via_points)
}

# Test helper for first booking id

r <- get_route_points(drop_off_points_splitted[[1]], start_point) %>%
  gh_get_route() %>%
  gh_as_sf()

sf::st_geometry(r) %>%
  plot()

# Loop over splitted routes

routes_sf <- purrr::map(drop_off_points_splitted, function(x) {
  get_route_points(x, start_point) %>%
    gh_get_route() %>%
    gh_as_sf()
})

sf::st_geometry(routes_sf[[1]]) %>%
  plot()
