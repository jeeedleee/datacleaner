#' Generate column context for prompt
#'
#' @param data Data frame
#' @param column_name Column name
#' @return Character string with column statistics
generate_column_context <- function(data, column_name) {
  col <- data[[column_name]]

  info <- list(
    name = column_name,
    type = class(col)[1],
    n_rows = length(col),
    n_na = sum(is.na(col)),
    n_unique = length(unique(col))
  )

  if (is.numeric(col)) {
    info$min <- min(col, na.rm = TRUE)
    info$max <- max(col, na.rm = TRUE)
    info$mean <- round(mean(col, na.rm = TRUE), 2)
  } else if (is.character(col) || is.factor(col)) {
    sample_vals <- head(unique(as.character(col)), 5)
    info$sample_values <- paste(sample_vals, collapse = ", ")
  }

  paste0(
    "Column: ", info$name, "\n",
    "Type: ", info$type, "\n",
    "Rows: ", info$n_rows, "\n",
    "Missing: ", info$n_na, "\n",
    "Unique: ", info$n_unique, "\n",
    if (!is.null(info$min)) paste0("Range: ", info$min, " - ", info$max, "\n") else "",
    if (!is.null(info$sample_values)) paste0("Samples: ", info$sample_values, "\n") else ""
  )
}
