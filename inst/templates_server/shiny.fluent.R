#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shiny.fluent
#' @noRd
app_server <- function( input, output, session ) {
  output$sliderValue <- renderText({
    sprintf("Value: %s", input$slider)
  })
}
