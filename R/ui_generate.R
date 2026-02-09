#' Generate tab UI
#'
#' @return Shiny UI element
generate_tab_ui <- function() {
  miniUI::miniContentPanel(
    shiny::actionButton("generate_code", "生成代码",
                        class = "btn-success"),
    shiny::hr(),
    shiny::h4("生成的代码:"),
    shiny::verbatimTextOutput("code_output"),
    shiny::h4("说明:"),
    shiny::textOutput("explanation_output"),
    shiny::h4("风险提示:"),
    shiny::textOutput("risks_output"),
    shiny::hr(),
    shiny::actionButton("insert_code", "插入到编辑器",
                        class = "btn-primary")
  )
}
