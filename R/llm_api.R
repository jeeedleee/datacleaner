#' Call LLM API
#'
#' @param prompt User prompt
#' @param system_prompt System prompt
#' @param config API configuration list
#' @return Parsed response from LLM
call_llm_api <- function(prompt, system_prompt, config) {
  if (is.null(config$api_key) || config$api_key == "") {
    stop("API key not configured")
  }

  url <- paste0(config$base_url, "/v1/chat/completions")

  messages <- list(
    list(role = "system", content = system_prompt),
    list(role = "user", content = prompt)
  )

  body <- list(
    model = config$model,
    messages = messages,
    temperature = 0.3
  )

  resp <- httr2::request(url) |>
    httr2::req_headers(
      "Authorization" = paste("Bearer", config$api_key),
      "Content-Type" = "application/json"
    ) |>
    httr2::req_body_json(body) |>
    httr2::req_perform()

  result <- httr2::resp_body_json(resp)
  content <- result$choices[[1]]$message$content

  parse_llm_response(content)
}
