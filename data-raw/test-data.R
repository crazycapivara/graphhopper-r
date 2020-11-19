## code to prepare `test-data` dataset goes here

start_point <- c(52.592204, 13.414307)
end_point <- c(52.539614, 13.364868)

route <- gh_get_route(list(start_point, end_point))
saveRDS(route, "tests/testthat/data/route-data.rds")

spt <- gh_get_spt(end_point, time_limit = 180)
saveRDS(spt, "tests/testthat/data/spt-data.rds")

#usethis::use_data("test-data")
