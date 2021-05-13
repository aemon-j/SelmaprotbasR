#'@title Return the current GOTM model version
#'
#'@description
#'Returns the current version of the GOTM model being used
#'
#'@keywords methods
#'
#'@author
#'Tadhg Moore, Jorrit Mesman
#'@examples
#' print(gotm_version())
#'
#'@export

gotm_version <- function(){
  file_path <- system.file("extdata/", package = "SelmaprotbasR")
  run_gotm(file_path, verbose = FALSE, args = "--version")
}
