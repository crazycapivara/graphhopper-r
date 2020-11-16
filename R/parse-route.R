#' Extract the bounding box from an gh object
#' @param data A \code{gh_route} or \link{gh_info} object.
#' @seealso \link{gh_get_route}, \link{gh_get_info}
#' @export
gh_bbox <- function(data) {
  UseMethod("gh_bbox", data)
}

#' @name gh_bbox
#' @export
gh_bbox.gh_route <- function(data) {
  data$paths[[1]]$bbox %>%
    unlist()
}

#' @name gh_bbox
#' @export
gh_bbox.gh_info <- function(data) {
  data$bbox %>% unlist()
}

#' Extract the instructions from a gh route object
#' @param data A \code{gh_route} object.
#' @seealso \link{gh_get_route}
#' @export
gh_instructions <- function(data) {
  path <- data$paths[[1]]
  lapply(path$instructions, function(x) {
    x$start_id <- x$interval[[1]]
    x$end_id <- x$interval[[2]]
    x$interval <- NULL
    tibble::as_tibble(x)
  }) %>%
    dplyr::bind_rows()
}

gh_as_sf_points <- function(data) {
  #path <- data$paths[[1]]
  #points_sf <- googlePolylines::decode(path$points)[[1]][, c("lon", "lat")] %>%
  #  sf::st_as_sf(coords = c("lon", "lat"), crs = 4326)
  #points_sf$gh_id <- 1:nrow(points_sf) - 1
  #points_sf
  gh_as_sf(data, geom_type = "point")
}
