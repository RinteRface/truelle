#' The application User-Interface 
#' 
#' Fluent React UI template
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shiny.fluent
#' @importFrom glue glue
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    fluentPage(
      tags$style(".card { padding: 28px; margin-bottom: 28px; }"),
      makeCard(
        title = Text(variant = "xxLarge", "Hello world!"), 
        content = tagList(
          Slider.shinyInput("slider", value = 42, min = -100, max = 100),
          textOutput("sliderValue")
        ),
        size = 4, 
        style = "max-height: 320px;"
      )
      
    )
  )
}


makeCard <- function(title, content, size = 12, style = "") {
  div(
    class = glue("card ms-depth-8 ms-sm{size} ms-xl{size}"),
    style = style,
    Stack(
      tokens = list(childrenGap = 5),
      Text(variant = "large", title, block = TRUE),
      content
    )
  )
}


#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'My app'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

