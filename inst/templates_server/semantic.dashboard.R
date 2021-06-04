#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import semantic.dashboard
#' @noRd
app_server <- function( input, output, session ) {
  output$plot1 <- renderPlot(
    hist(rnorm(input$slider))
  )
}
