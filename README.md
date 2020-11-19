
<!-- README.md is generated from README.Rmd. Please edit that file -->
graphhopper-R
=============

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/graphhopper)](https://CRAN.R-project.org/package=graphhopper) [![Travis build status](https://travis-ci.org/crazycapivara/graphhopper-r.svg?branch=master)](https://travis-ci.org/crazycapivara/graphhopper-r) [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active) <!-- badges: end -->

`graphhopper` - An R Interace to the [graphhopper](https://www.graphhopper.com/) API

Installation
------------

Install the release version from [CRAN](https://cran.r-project.org/) with:

``` r
install.packages("mapboxer")
```

Install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("crazycapivara/graphhopper-r")
```

Get started
-----------

Run your own GraphHopper instance (with data of Berlin):

``` bash
docker run --name gh --rm -p 8989:8989 -d graphhopper/graphhopper:2.0
```

### Setup

``` r
library(graphhopper)

API_URL <- "http://localhost:8989"
gh_set_api_url(API_URL)
```

### Route

Get a route in Berlin:

``` r
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

![](man/figures/README-route-example-1.png)

``` r

route$time
#> [1] 697411

via_point <- c(52.545461, 13.435249)

route2 <- gh_get_route(list(start_point, via_point, end_point))

gh_time_distance(route2)
#> $time
#> [1] 1168950
#> 
#> $distance
#> [1] 12843.67

ggplot(data = gh_as_sf(route2)) +
  geom_sf() +
  theme_bw()
```

![](man/figures/README-route-example-2.png)

``` r

gh_points(route2) %>%
  head()
#>        lon      lat gh_id
#> 1 13.41422 52.59234     0
#> 2 13.41321 52.59212     1
#> 3 13.41483 52.58964     2
#> 4 13.41539 52.59004     3
#> 5 13.41599 52.59032     4
#> 6 13.41942 52.59145     5

gh_instructions(route2) %>%
  head()
#>        lon      lat gh_id distance heading sign
#> 1 13.41422 52.59234     0   72.248  250.06    0
#> 2 13.41321 52.59212     1  296.761      NA   -2
#> 3 13.41483 52.58964     2  373.025      NA   -3
#> 4 13.41942 52.59145     5  678.120      NA    2
#> 5 13.42352 52.58588     8  556.120      NA   -2
#> 6 13.43019 52.58851    15  619.849      NA    2
#>                                     text  time          street_name end_id
#> 1        Continue onto Buchholzer Straße 13004    Buchholzer Straße      1
#> 2       Turn left onto Buchholzer Straße 53416    Buchholzer Straße      2
#> 3 Turn sharp left onto Buchholzer Straße 29840    Buchholzer Straße      5
#> 4         Turn right onto Grumbkowstraße 54248       Grumbkowstraße      8
#> 5    Turn left onto Blankenburger Straße 47724 Blankenburger Straße     15
#> 6      Turn right onto Pasewalker Straße 50063    Pasewalker Straße     18
#>   last_heading
#> 1           NA
#> 2           NA
#> 3           NA
#> 4           NA
#> 5           NA
#> 6           NA
```

### Shortest path tree

``` r
start_point <- c(52.53961, 13.36487)

points_sf <- gh_get_spt(start_point, time_limit = 180) %>%
  gh_as_sf() %>%
  dplyr::mutate(time = (time / 1000 / 60))

ggplot() +
  geom_sf(data = points_sf, aes(colour = time), size = 0.5) +
  theme_bw()
```

![](man/figures/README-spt-example-1.png)

Also query previous nodes to plot the network:

``` r
(columns <- gh_spt_columns(
  prev_longitude = TRUE,
  prev_latitude = TRUE,
  prev_time = TRUE
))
#> [1] "longitude"      "latitude"       "time"           "distance"      
#> [5] "prev_longitude" "prev_latitude"  "prev_time"

lines_sf <- gh_get_spt(end_point, time_limit = 240, columns = columns) %>%
  dplyr::mutate(mean_time = ((time + prev_time) / 2) / 1000 / 60) %>%
  gh_spt_as_linestrings_sf()

ggplot() +
  geom_sf(data = lines_sf, aes(color = mean_time), size = 1) +
  theme(axis.text.x = element_text(angle = 45))
```

![](man/figures/README-spt-example-lines-1.png)
