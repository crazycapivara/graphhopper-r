#' @export
gh_bbox <- function(content) {
  content$paths[[1]]$bbox %>%
    unlist()
}

#' @export
gh_instructions <- function(content) {
  path <- content$paths[[1]]
  lapply(path$instructions, function(x) {
    x$start_id <- x$interval[[1]]
    x$end_id <- x$interval[[2]]
    x$interval <- NULL
    tibble::as_tibble(x)
  }) %>%
    dplyr::bind_rows()
}

#' @export
gh_as_sf_points <- function(content) {
  path <- content$paths[[1]]
  points_sf <- googlePolylines::decode(path$points)[[1]][, c("lon", "lat")] %>%
    sf::st_as_sf(coords = c("lon", "lat"), crs = 4326)
  points_sf$gh_id <- 1:nrow(points_sf) - 1
  points_sf
}
