#' Build complete prompt for LLM
#'
#' @param data Data frame
#' @param rules List of cleaning rules
#' @return Character string with complete prompt
build_prompt <- function(data, rules) {
  if (length(rules) == 0) {
    stop("No cleaning rules specified")
  }

  # Build context for each column with rules
  contexts <- lapply(names(rules), function(col_name) {
    if (col_name %in% names(data)) {
      generate_column_context(data, col_name)
    } else {
      paste0("Column: ", col_name, " (not found in data)\n")
    }
  })

  # Build rules section
  rules_text <- lapply(names(rules), function(col_name) {
    paste0("- Column '", col_name, "': ", rules[[col_name]])
  })

  paste0(
    "Data Overview:\n",
    "Total rows: ", nrow(data), "\n",
    "Total columns: ", ncol(data), "\n\n",
    "Column Information:\n",
    paste(contexts, collapse = "\n"),
    "\nCleaning Rules:\n",
    paste(rules_text, collapse = "\n"),
    "\n\nGenerate R code to apply these cleaning rules to the data frame 'df'."
  )
}
