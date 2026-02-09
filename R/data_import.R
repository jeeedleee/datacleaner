#' Import data from file
#'
#' @param file_path Path to the data file
#' @return A data frame
import_data <- function(file_path) {
  ext <- tolower(tools::file_ext(file_path))

  if (ext == "csv") {
    import_csv(file_path)
  } else if (ext %in% c("xlsx", "xls")) {
    readxl::read_excel(file_path)
  } else {
    stop("Unsupported file format: ", ext)
  }
}

#' Import CSV with encoding detection
#'
#' @param file_path Path to CSV file
#' @return A data frame
import_csv <- function(file_path) {
  # Try UTF-8 first
  result <- tryCatch({
    readr::read_csv(file_path, locale = readr::locale(encoding = "UTF-8"),
                    show_col_types = FALSE)
  }, error = function(e) NULL)

  if (!is.null(result)) {
    return(result)
  }

  # Try GBK for Chinese encoding
 tryCatch({
    readr::read_csv(file_path, locale = readr::locale(encoding = "GBK"),
                    show_col_types = FALSE)
  }, error = function(e) {
    stop("Failed to read CSV file with UTF-8 or GBK encoding")
  })
}
