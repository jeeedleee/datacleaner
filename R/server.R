#' Server logic for datacleaner gadget
#'
#' @param input Shiny input
#' @param output Shiny output
#' @param session Shiny session
datacleaner_server <- function(input, output, session) {
  # Reactive values
  rv <- shiny::reactiveValues(
    data = NULL,
    rules = list(),
    generated = NULL,
    selected_column = NULL
  )

  # Settings module
 api_config <- settingsServer("settings")

  # Data import handler
  shiny::observeEvent(input$file_input, {
    req(input$file_input)
    tryCatch({
      rv$data <- import_data(input$file_input$datapath)
      shiny::updateSelectInput(session, "column_select",
                               choices = names(rv$data))
      shiny::showNotification("数据导入成功!", type = "message")
    }, error = function(e) {
      shiny::showNotification(paste("错误:", e$message), type = "error")
    })
  })

  # Data info output
  output$data_info <- shiny::renderText({
    if (is.null(rv$data)) return("未加载数据")
    paste0(nrow(rv$data), " 行 x ", ncol(rv$data), " 列")
  })

  # Data table output
  output$data_table <- DT::renderDT({
    req(rv$data)
    DT::datatable(rv$data,
                  selection = list(mode = 'single', target = 'column'),
                  options = list(pageLength = 5, scrollX = TRUE))
  })

  # Column selection observer
  shiny::observeEvent(input$data_table_columns_selected, {
    col_idx <- input$data_table_columns_selected
    if (length(col_idx) > 0 && !is.null(rv$data)) {
      rv$selected_column <- names(rv$data)[col_idx]
    }
  })

  # Column info output
  output$column_info <- shiny::renderText({
    req(rv$data, rv$selected_column)
    col <- rv$data[[rv$selected_column]]
    info <- paste0(
      "类型: ", class(col)[1], "\n",
      "行数: ", length(col), "\n",
      "缺失: ", sum(is.na(col)), "\n",
      "唯一值: ", length(unique(col))
    )
    if (is.numeric(col)) {
      info <- paste0(info, "\n",
        "最小值: ", min(col, na.rm = TRUE), "\n",
        "最大值: ", max(col, na.rm = TRUE))
    }
    info
  })

  # Selected column name output
  output$selected_column_name <- shiny::renderText({
    if (is.null(rv$selected_column)) return("请先选择一列")
    paste0("当前列: ", rv$selected_column)
  })

  # Add rule handler
  shiny::observeEvent(input$add_rule, {
    req(rv$selected_column, input$rule_input)
    if (nchar(trimws(input$rule_input)) > 0) {
      rv$rules[[rv$selected_column]] <- input$rule_input
      shiny::updateTextAreaInput(session, "rule_input", value = "")
      shiny::showNotification("规则已添加!", type = "message")
    }
  })

  # Rules list output
  output$rules_list <- shiny::renderUI({
    if (length(rv$rules) == 0) {
      return(shiny::p("暂无规则"))
    }
    rule_items <- lapply(names(rv$rules), function(col) {
      shiny::div(
        shiny::strong(col), ": ", rv$rules[[col]],
        shiny::actionLink(paste0("remove_", col), " [删除]"),
        shiny::br()
      )
    })
    shiny::tagList(rule_items)
  })

  # Remove rule observers
  shiny::observe({
    lapply(names(rv$rules), function(col) {
      shiny::observeEvent(input[[paste0("remove_", col)]], {
        rv$rules[[col]] <- NULL
      }, ignoreInit = TRUE)
    })
  })

  # Generate code handler
  shiny::observeEvent(input$generate_code, {
    req(rv$data, length(rv$rules) > 0)

    config <- api_config()
    if (is.null(config$api_key) || config$api_key == "") {
      shiny::showNotification("请先在设置中配置 API 密钥",
                              type = "error")
      return()
    }

    shiny::showNotification("正在生成代码...", type = "message")

    tryCatch({
      prompt <- build_prompt(rv$data, rv$rules)
      system_prompt <- get_system_prompt()
      rv$generated <- call_llm_api(prompt, system_prompt, config)
      shiny::showNotification("代码生成成功!", type = "message")
    }, error = function(e) {
      shiny::showNotification(paste("错误:", e$message), type = "error")
    })
  })

  # Code output
  output$code_output <- shiny::renderText({
    if (is.null(rv$generated)) return("")
    rv$generated$code
  })

  # Explanation output
  output$explanation_output <- shiny::renderText({
    if (is.null(rv$generated)) return("")
    rv$generated$explanation
  })

  # Risks output
  output$risks_output <- shiny::renderText({
    if (is.null(rv$generated)) return("")
    rv$generated$risks
  })

  # Insert code handler
  shiny::observeEvent(input$insert_code, {
    req(rv$generated$code)
    insert_code_to_rstudio(rv$generated$code)
    shiny::showNotification("代码已插入!", type = "message")
  })

  # Done button handler
  shiny::observeEvent(input$done, {
    shiny::stopApp()
  })
}
