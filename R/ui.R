#' Create the main UI for datacleaner gadget
#'
#' @return Shiny UI object
datacleaner_ui <- function() {
  miniUI::miniPage(
    miniUI::gadgetTitleBar("数据清洗助手"),
    miniUI::miniTabstripPanel(
      miniUI::miniTabPanel("数据", icon = shiny::icon("table"),
        miniUI::miniContentPanel(
          scrollable = TRUE,
          shiny::fluidRow(
            shiny::column(4,
              shiny::fileInput("file_input", "导入数据 (CSV/Excel):",
                              accept = c(".csv", ".xlsx", ".xls"))
            ),
            shiny::column(8,
              shiny::br(),
              shiny::textOutput("data_info")
            )
          ),
          shiny::hr(),
          shiny::fluidRow(
            shiny::column(8,
              shiny::h4("数据预览 (点击列添加规则)"),
              DT::DTOutput("data_table", height = "280px")
            ),
            shiny::column(4,
              shiny::h4("列信息"),
              shiny::verbatimTextOutput("column_info"),
              shiny::hr(),
              shiny::h4("添加规则"),
              shiny::textOutput("selected_column_name"),
              shiny::textAreaInput("rule_input", NULL,
                                  placeholder = "例如：转换为数值类型",
                                  rows = 2),
              shiny::actionButton("add_rule", "添加规则", class = "btn-primary btn-sm"),
              shiny::hr(),
              shiny::h5("已添加的规则:"),
              shiny::uiOutput("rules_list")
            )
          )
        )
      ),
      miniUI::miniTabPanel("生成代码", icon = shiny::icon("code"),
        generate_tab_ui()
      ),
      miniUI::miniTabPanel("设置", icon = shiny::icon("cog"),
        miniUI::miniContentPanel(
          settingsUI("settings")
        )
      )
    )
  )
}
