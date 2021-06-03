#' The application User-Interface 
#' 
#' shinyMobile tabs layout template
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
      f7TabLayout(
        panels = tagList(
          f7Panel(
            title = "Left Panel", 
            side = "left", 
            theme = "light", 
            "Blabla", 
            effect = "cover"
          ),
          f7Panel(
            title = "Right Panel", 
            side = "right", 
            theme = "dark", 
            "Blabla", 
            effect = "reveal"
          )
        ),
        navbar = f7Navbar(
          title = "Tabs",
          hairline = TRUE,
          shadow = TRUE,
          leftPanel = TRUE,
          rightPanel = TRUE
        ),
        f7Tabs(
          animated = TRUE,
          f7Tab(
            tabName = "Tab 1",
            icon = f7Icon("folder"),
            active = TRUE,
            f7Stepper(
              inputId = "stepper",
              label = "My stepper",
              min = 0,
              max = 10,
              size = "small",
              value = 4,
              wraps = TRUE,
              autorepeat = TRUE,
              rounded = FALSE,
              raised = FALSE,
              manual = FALSE
            ),
            verbatimTextOutput("val")
          ),
          f7Tab(
            tabName = "Tab 2",
            icon = f7Icon("keyboard"),
            active = FALSE,
            "Tab 2"
          ),
          f7Tab(
            tabName = "Tab 3",
            icon = f7Icon("layers_alt"),
            active = FALSE,
            "Tab 3"
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
      app_title = 'My app'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}
