start_point <- c(52.592204, 13.414307)
end_point <- c(52.539614, 13.364868)

route <- gh_get_route_v2(list(start_point, end_point))
