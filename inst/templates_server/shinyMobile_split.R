#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @noRd
app_server <- function( input, output, session ) {
  output$selected_tab <- renderUI({
    HTML(paste0("Selected tab: ", strong(input$menu)))
  })
  
  output$distPlot <- renderPlot({
    dist <- rnorm(input$obs)
    hist(dist)
  })
}