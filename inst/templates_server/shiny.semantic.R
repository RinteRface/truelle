#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shiny.semantic
#' @noRd
app_server <- function( input, output, session ) {
  observeEvent(input$button, {
    modal <- create_modal(
      modal(
        id = "simple-modal",
        header = h2("Important message"),
        "This is an important message!"
      ),
      show = TRUE,
      session = getDefaultReactiveDomain()
    )
    showModal(modal, session = getDefaultReactiveDomain())
  })
}
