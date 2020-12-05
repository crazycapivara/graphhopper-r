if (FALSE) {
  info <- gh_get_info()

  message(info$version)
  message(info$data_date)
  print(gh_bbox(info))
}
