API_URL <- "http://localhost:8989/"

set_api_url(API_URL)

from_lnglat <- c(52.592204, 13.414307)
to_lnglat <- c(52.539614, 13.364868)

resp <- get_route(from_lnglat, to_lnglat)
get_route_sf(from_lnglat, to_lnglat)
