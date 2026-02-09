#' Launch the Data Cleaner Addin
#'
#' @export
datacleaner_addin <- function() {
  shiny::runGadget(
    datacleaner_ui(),
    datacleaner_server,
    viewer = shiny::dialogViewer("Data Cleaner", width = 1200, height = 800)
  )
}
