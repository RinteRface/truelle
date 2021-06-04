#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import bs4Dash 
#' @noRd
app_server <- function( input, output, session ) {
  output$plot <- renderPlot({
    req(!input$mybox$collapsed)
    plot(rnorm(200))
  })
  
  output$box_state <- renderText({
    state <- if (input$mybox$collapsed) "collapsed" else "uncollapsed"
    paste("My box is", state)
  })
  
  observeEvent(input$toggle_box, {
    updateBox("mybox", action = "toggle")
  })
  
  observeEvent(input$remove_box, {
    updateBox("mybox", action = "remove")
  })
  
  observeEvent(input$restore_box, {
    updateBox("mybox", action = "restore")
  })
  
  observeEvent(input$update_box, {
    updateBox(
      "mybox",
      action = "update",
      options = list(
        title = h2("New title", dashboardBadge(1, color = "primary")),
        status = "danger",
        solidHeader = TRUE,
        width = 4
      )
    )
  })
  
  observeEvent(input$mybox$visible, {
    collapsed <- if (input$mybox$collapsed) "collapsed" else "uncollapsed"
    visible <- if (input$mybox$visible) "visible" else "hidden"
    message <- paste("My box is", collapsed, "and", visible)
    toast(
      title = message,
      options = list(
        autohide = TRUE,
        class = "bg-pink",
        position = "topRight"
      )
    )
  })
}
