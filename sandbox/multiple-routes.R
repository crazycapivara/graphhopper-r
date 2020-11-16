data_url <- "https://www.berlin.de/sen/web/service/liefer-und-abholdienste/index.php/index/all.csv?q="
x <- data.table::fread(data_url)

data_url <- "https://www.berlin.de/sen/web/service/liefer-und-abholdienste/index.php/index/all.gjson?q="
x <- sf::st_read(data_url)

y <- jsonlite::fromJSON(data_url)

library(mapboxer)

mapboxer(bounds = sf::st_bbox(x)) %>%
  add_circle_layer(
    source = as_mapbox_source(x)
    , circle_color = "red"
  )
