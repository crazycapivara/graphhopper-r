#' Extract the bounding box from a gh object
#' @param data A \code{gh_route} or \code{gh_info} object.
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
#' @param instructions_only Whether to return the instructions without the corresponding points.
#' @seealso \link{gh_get_route}
#' @export
gh_instructions <- function(data, instructions_only = FALSE) {
  path <- data$paths[[1]]
  instructions <- lapply(path$instructions, function(x) {
    x$gh_start_id <- x$interval[[1]]
    x$gh_end_id <- x$interval[[2]]
    x$interval <- NULL
    tibble::as_tibble(x)
  }) %>%
    dplyr::bind_rows()
  if (instructions_only) return(instructions)

  gh_points(data) %>%
    dplyr::inner_join(instructions, by = c(gh_id = "gh_start_id"))
}

#' Extract the points from a gh route object
#' @param data A \code{gh_route} object.
#' @export
gh_points <- function(data) {
  path <- data$paths[[1]]
  googlePolylines::decode(path$points)[[1]][, c("lon", "lat")] %>%
    dplyr::mutate(gh_id = (1:nrow(.) - 1))
}

#' Extract time and distance from a gh route object
#' @param data A \code{gh_route} object.
#' @export
gh_time_distance <- function(data) {
  path <- data$paths[[1]]
  list(time = path$time, distance = path$distance)
}

# Obselete?
gh_as_sf_points <- function(data) {
  gh_as_sf(data, geom_type = "point")
}
