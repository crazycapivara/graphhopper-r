API_URL <- "http://localhost:8989/"

gh_set_api_url(API_URL)

start_point <- c(52.592204, 13.414307)
end_point <- c(52.539614, 13.364868)

route <- route_get(list(start_point, end_point))
# resp <- get_route(from_lnglat, to_lnglat)
# get_route_sf(from_lnglat, to_lnglat)
