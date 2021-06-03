#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @importFrom shinyAce aceEditor 
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    f7Page(
      title = "{truelle}",
      f7TabLayout(
        panels = tagList(
          f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", effect = "cover"),
          f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", effect = "cover")
        ),
        navbar = f7Navbar(
          title = "{truelle}",
          hairline = TRUE,
          shadow = TRUE,
          f7Flex(
            f7Back(targetId = "widget_nav"),
            f7Next(targetId = "widget_nav"),
            a(
              href = "#", 
              id = "close_app",
              class = "button button-small action-button display-flex margin-left-half", 
              f7Icon("xmark_circle")
            )
          )
        ),
        f7Tabs(
          id = "widget_nav",
          animated = TRUE,
          #swipeable = TRUE,
          f7Tab(
            tabName = "Home",
            icon = f7Icon("house"),
            active = TRUE,
            
            tags$head(
              tags$script(
                "$(function() {
                  Shiny.addCustomMessageHandler('toggle_project_type', function(message) {
                    if (message === 'placeholder') {
                      $('#engine_type').hide();
                      $('#engine_type').siblings().last().hide();
                    } else {
                      $('#engine_type').show();
                      $('#engine_type').siblings().last().show();
                    }
                    $()
                  });
                  
                  Shiny.addCustomMessageHandler('toggle_run_button', function(message) {
                    if (message) {
                      $('#run_code_output').show();
                    } else {
                      $('#run_code_output').hide();
                    }
                  });
                });"
              )
            ),
            
            f7Select(
              inputId = "project_type",
              label = "Project Type",
              choices = c(
                "Select a project type" = "placeholder",
                "Package" = "package", 
                "Simple app" = "simple", 
                "Extension" = "extension"
              ),
              selected = NULL
            ),
            truelle::f7Radio(
              inputId = "engine_type",
              label = "Select an engine",
              choices = NULL
            )
          ),
          f7Tab(
            tabName = "Configuration",
            icon = f7Icon("gear"),
            uiOutput("config_steps")
          ),
          f7Tab(
            tabName = "Template",
            icon = f7Icon("paintbrush"),
            truelle::f7Radio(
              inputId = "selected_template",
              label = "Selected template",
              choices = list(
                shinyMobile = list(
                  checked = FALSE,
                  title = "shinyMobile_simple",
                  subtitle = "Simplest {shinyMobile} template",
                  text = "Ideal for simple apps with one page content"
                )
              )
            )
          ),
          f7Tab(
            tabName = "Output",
            icon = f7Icon("document_text"),
            f7Segment(
              f7Button(
                "run_code_output",
                "Run code"
              )
            ),
            aceEditor(
              outputId = "code_output",
              value = "",
              mode = "r",
              theme = "monokai"
            )
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

