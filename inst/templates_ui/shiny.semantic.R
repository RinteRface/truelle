#' The application User-Interface 
#' 
#' Bootstrap 3 dashboard template
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shiny.semantic
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    semanticPage(
      div(
        class = "ui raised segment",
        div(
          a(class="ui green ribbon label", "Link"),
          p("Lorem ipsum, lorem ipsum, lorem ipsum"),
          progress("progress", percent = 24, label = "{percent}% complete"),
          actionButton("button", "Click me!")
        )
      )
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

