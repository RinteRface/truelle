#' The application User-Interface 
#' 
#' shinyMobile single layout template
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    f7Page(
      allowPWA = FALSE,
      options = list(
        theme = c("ios", "md", "auto", "aurora"),
        dark = TRUE, 
        filled = FALSE,
        color = "#007aff", 
        touch = list(
          tapHold = TRUE, 
          tapHoldDelay = 750, 
          iosTouchRipple = FALSE
        ), 
        iosTranslucentBars = FALSE, 
        navbar = list(
          iosCenterTitle = TRUE,
          hideOnPageScroll = TRUE
        ), 
        toolbar = list(hideOnPageScroll = FALSE), 
        pullToRefresh = FALSE
      ),
      title = "My app",
      f7SingleLayout(
        navbar = f7Navbar(
          title = "Single Layout",
          hairline = TRUE,
          shadow = TRUE
        ),
        toolbar = f7Toolbar(
          position = "bottom",
          f7Link(label = "Link 1", href = "https://www.google.com"),
          f7Link(label = "Link 2", href = "https://www.google.com")
        ),
        # main content
        f7Shadow(
          intensity = 16,
          hover = TRUE,
          f7Card(
            title = "Card header",
            f7CheckboxGroup(
              inputId = "variable",
              label = "Choose a variable:",
              choices = colnames(mtcars)[-1],
              selected = NULL
            ),
            tableOutput("data")
          )
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
      app_title = '{truelle}'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}
