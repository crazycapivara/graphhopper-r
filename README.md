
<!-- README.md is generated from README.Rmd. Please edit that file -->
graphhopper-R
=============

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

`graphhopper` - An R Interace to the [graphhopper](https://www.graphhopper.com/) API

Installation
------------

You can install the latest version of `graphhopper` from github with:

``` r
# install.packages("devtools")
devtools::install_github("crazycapivara/graphhopper-r")
```

Get started
-----------

Run your own graphhoper API (Berlin):

``` bash
docker run -p 8989:8989 -d crazycapivara/graphhopper
```

Get a route in Berlin:

``` r
library(graphhopper)

# Setup
API_URL <- "http://localhost:8989/"
set_api_url(API_URL)

start_point <- c(52.592204, 13.414307)
end_point <- c(52.539614, 13.364868)

(route <- get_route_sf(start_point, end_point))
#> Simple feature collection with 1 feature and 2 fields
#> geometry type:  LINESTRING
#> dimension:      XY
#> bbox:           xmin: 13.36502 ymin: 52.5395 xmax: 13.41484 ymax: 52.59235
#> epsg (SRID):    4326
#> proj4string:    +proj=longlat +datum=WGS84 +no_defs
#>     time distance                              .
#> 1 712414 7676.601 LINESTRING (13.41422 52.592...

sf::st_geometry(route) %>%
  plot()
```

<img src="man/figures/README-example-1.png" width="400px" />

``` r

route$time
#> [1] 712414

sf::st_coordinates(route)[, c("X", "Y")] %>%
  head()
#>             X        Y
#> [1,] 13.41422 52.59235
#> [2,] 13.41322 52.59212
#> [3,] 13.41484 52.58964
#> [4,] 13.41314 52.58824
#> [5,] 13.41247 52.58770
#> [6,] 13.41366 52.58594
```
