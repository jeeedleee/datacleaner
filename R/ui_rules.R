#' Rules tab UI
#'
#' @return Shiny UI element
rules_tab_ui <- function() {
  miniUI::miniContentPanel(
    shiny::fluidRow(
      shiny::column(4,
        shiny::selectInput("column_select", "Select Column:", choices = NULL)
      ),
      shiny::column(8,
        shiny::textAreaInput("rule_input", "Cleaning Rule:",
                            placeholder = "e.g., Remove rows with missing values",
                            rows = 2)
      )
    ),
    shiny::actionButton("add_rule", "Add Rule", class = "btn-primary btn-sm"),
    shiny::hr(),
    shiny::h4("Current Rules:"),
    shiny::uiOutput("rules_list")
  )
}
