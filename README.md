
<!-- README.md is generated from README.Rmd. Please edit that file -->
graphhopper-R
=============

[![Travis build status](https://travis-ci.org/crazycapivara/graphhopper-r.svg?branch=master)](https://travis-ci.org/crazycapivara/graphhopper-r) [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

`graphhopper` - An R Interace to the [graphhopper](https://www.graphhopper.com/) API

Installation
------------

You can install the latest version of `graphhopper` from github with:

``` r
# install.packages("remotes")
remotes::install_github("crazycapivara/graphhopper-r")
```

Get started
-----------

Run your own GraphHopper instance (Berlin):

``` bash
docker run --name gh --rm -p 8989:8989 -d graphhopper/graphhopper:2.0
```

Get a route in Berlin:

``` r
library(graphhopper)

# Setup
API_URL <- "http://localhost:8989"
gh_set_api_url(API_URL)

start_point <- c(52.592204, 13.414307)
end_point <- c(52.539614, 13.364868)

(route <- gh_get_route(list(start_point, end_point)) %>%
    gh_as_sf())
#> Simple feature collection with 1 feature and 2 fields
#> geometry type:  LINESTRING
#> dimension:      XY
#> bbox:           xmin: 13.36501 ymin: 52.53949 xmax: 13.41483 ymax: 52.59234
#> CRS:            EPSG:4326
#>     time distance                       geometry
#> 1 697411 7541.318 LINESTRING (13.41422 52.592...

ggplot(data = route) +
  geom_sf() +
  theme_bw()
```

![](man/figures/README-example-1.png)

``` r

route$time
#> [1] 697411

via_point <- c(52.545461, 13.435249)

route2 <- gh_get_route(list(start_point, via_point, end_point), miles = TRUE) %>%
  gh_as_sf()

route2$time
#> [1] 1168950

ggplot(data = route2) +
  geom_sf() +
  theme_bw()
```

![](man/figures/README-example-2.png)

``` r

sf::st_coordinates(route2)[, c("X", "Y")] %>%
  head()
#>          X        Y
#> 1 13.41422 52.59234
#> 2 13.41321 52.59212
#> 3 13.41483 52.58964
#> 4 13.41539 52.59004
#> 5 13.41599 52.59032
#> 6 13.41942 52.59145

# Shortest path tree
start_point <- c(52.53961, 13.36487)

points_sf <- gh_get_spt(start_point, time_limit = 180) %>%
  gh_as_sf() %>%
  dplyr::mutate(time = as.integer(time/1000/60))

ggplot() +
  geom_sf(data = points_sf, aes(colour = time), size = 0.5) +
  theme_bw()
```

![](man/figures/README-example-3.png)
