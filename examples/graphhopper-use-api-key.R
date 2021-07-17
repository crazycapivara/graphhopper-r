library(graphhopper)

key <- "your-api-key"
Sys.setenv(GH_API_KEY = key)

gh_set_api_url("https://graphhopper.com/api/1/")

start_point <- c(52.592204, 13.414307)
end_point <- c(52.539614, 13.364868)

gh_get_route(list(start_point, end_point)) %>%
  gh_as_sf()
