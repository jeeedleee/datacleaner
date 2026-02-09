#' Get configuration file path
#'
#' @return Character string with path to config file
get_config_path <- function() {

  config_dir <- file.path(Sys.getenv("HOME"), ".datacleaner")
  if (!dir.exists(config_dir)) {
    dir.create(config_dir, recursive = TRUE)
  }
  file.path(config_dir, "config.yml")
}

#' Get API configuration
#'
#' @return List with API configuration (base_url, api_key, model)
get_api_config <- function() {
  config_path <- get_config_path()

  default_config <- list(
    base_url = "https://537-ai.net",
    api_key = "",
    model = "gpt-4"
  )

  if (file.exists(config_path)) {
    tryCatch({
      config <- yaml::read_yaml(config_path)
      modifyList(default_config, config)
    }, error = function(e) {
      default_config
    })
  } else {
    default_config
  }
}

#' Save API configuration
#'
#' @param base_url API base URL
#' @param api_key API key
#' @param model Model name
#' @return Invisible NULL
save_api_config <- function(base_url, api_key, model) {
  config <- list(
    base_url = base_url,
    api_key = api_key,
    model = model
  )
  yaml::write_yaml(config, get_config_path())
  invisible(NULL)
}

#' Settings UI Module
#'
#' @param id Module ID
#' @return Shiny UI element
settingsUI <- function(id) {


  ns <- shiny::NS(id)
  config <- get_api_config()

  shiny::tagList(
    shiny::passwordInput(ns("api_key"), "API 密钥:", value = config$api_key),
    shiny::textInput(ns("model"), "模型:", value = config$model),
    shiny::actionButton(ns("save_settings"), "保存设置",
                        class = "btn-primary btn-sm")
  )
}

#' Settings Server Module
#'
#' @param id Module ID
#' @return Module server function
settingsServer <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {

    shiny::observeEvent(input$save_settings, {
      save_api_config("https://537-ai.net", input$api_key, input$model)
      shiny::showNotification("设置已保存!", type = "message")
    })

    shiny::reactive({
      list(
        base_url = "https://537-ai.net",
        api_key = input$api_key,
        model = input$model
      )
    })
  })
}
