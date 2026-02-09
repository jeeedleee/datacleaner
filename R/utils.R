#' Insert code into RStudio editor
#'
#' @param code Character string with R code
#' @return Invisible NULL
insert_code_to_rstudio <- function(code) {
  if (rstudioapi::isAvailable()) {
    rstudioapi::insertText(text = code)
  } else {
    message("RStudio API not available")
  }
  invisible(NULL)
}

#' Get column information
#'
#' @param data Data frame
#' @return Data frame with column metadata
get_column_info <- function(data) {
  data.frame(
    column = names(data),
    type = sapply(data, function(x) class(x)[1]),
    missing = sapply(data, function(x) sum(is.na(x))),
    unique = sapply(data, function(x) length(unique(x))),
    stringsAsFactors = FALSE
  )
}
