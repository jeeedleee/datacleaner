#' Parse LLM response
#'
#' @param content Raw content from LLM
#' @return List with code, explanation, and risks
parse_llm_response <- function(content) {
  # Try to extract JSON from response
  json_match <- regmatches(content,
    regexpr("\\{[^{}]*\"code\"[^{}]*\\}", content, perl = TRUE))

 if (length(json_match) > 0 && nchar(json_match) > 0) {
    tryCatch({
      return(jsonlite::fromJSON(json_match))
    }, error = function(e) NULL)
  }

  # Fallback: parse structured text
  parse_structured_response(content)
}

#' Parse structured text response
#'
#' @param content Raw text content
#' @return List with code, explanation, and risks
parse_structured_response <- function(content) {
  code <- ""
  explanation <- ""
  risks <- ""

  # Extract code block
  code_match <- regmatches(content,
    regexpr("```r?\\n([\\s\\S]*?)```", content, perl = TRUE))
  if (length(code_match) > 0) {
    code <- gsub("```r?\\n|```", "", code_match)
  }

  # Extract explanation
  exp_match <- regmatches(content,
    regexpr("(?i)explanation[:\\s]*([^#]*?)(?=risk|$)", content, perl = TRUE))
  if (length(exp_match) > 0) {
    explanation <- trimws(gsub("(?i)explanation[:\\s]*", "", exp_match))
  }

  # Extract risks
  risk_match <- regmatches(content,
    regexpr("(?i)risk[s]?[:\\s]*(.*)$", content, perl = TRUE))
  if (length(risk_match) > 0) {
    risks <- trimws(gsub("(?i)risk[s]?[:\\s]*", "", risk_match))
  }

  list(code = code, explanation = explanation, risks = risks)
}
