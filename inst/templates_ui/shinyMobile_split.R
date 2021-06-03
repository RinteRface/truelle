#' The application User-Interface 
#' 
#' shinyMobile split layout template
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
      f7SplitLayout(
        sidebar = f7Panel(
          id = "sidebar",
          title = "Sidebar",
          side = "left",
          theme = "dark",
          f7PanelMenu(
            id = "menu",
            f7PanelItem(
              tabName = "tab1", 
              title = "Tab 1", 
              icon = f7Icon("envelope"), 
              active = TRUE
            ),
            f7PanelItem(
              tabName = "tab2", 
              title = "Tab 2", 
              icon = f7Icon("house")
            )
          ),
          uiOutput("selected_tab")
        ),
        navbar = f7Navbar(
          title = "Split Layout",
          hairline = FALSE,
          shadow = TRUE
        ),
        toolbar = f7Toolbar(
          position = "bottom",
          f7Link(label = "Link 1", href = "https://www.google.com"),
          f7Link(label = "Link 2", href = "https://www.google.com")
        ),
        # main content
        f7Items(
          f7Item(
            tabName = "tab1",
            f7Slider("obs", "Number of observations:",
                     min = 0, max = 1000, value = 500
            ),
            plotOutput("distPlot")
          ),
          f7Item(tabName = "tab2", "Tab 2 content")
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
