library(graphhopper)
library(ggplot2)

start_point <- c(52.53961, 13.36487)
end_point <- c(52.539614, 13.364868)

columns <- c(
  #"node_id",
  "longitude", "latitude",
  "prev_longitude", "prev_latitude",
  "time", "prev_time"
)

points <- gh_get_spt(end_point, time_limit = 240, columns = columns) %>%
  dplyr::mutate(mean_time = ((time + prev_time) / 2) / 1000 / 60)

lines_sf <- gh_spt_as_linestrings_sf(points)

ggplot(data = lines_sf) +
  geom_sf(aes(color = mean_time)) +
  theme_void()
