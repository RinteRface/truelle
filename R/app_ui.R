#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @importFrom shinyAce aceEditor
#' @importFrom rclipboard rclipboardSetup 
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    f7Page(
      options = list(
        theme = "md",
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
          hideNavOnPageScroll = TRUE,
          mdCenterTitle = TRUE
        ),
        toolbar = list(
          hideNavOnPageScroll = FALSE
        ),
        pullToRefresh = FALSE
      ),
      title = "{truelle}",
      f7TabLayout(
        #panels = tagList(
        #  f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", effect = "cover"),
        #  f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", effect = "cover")
        #),
        navbar = f7Navbar(
          title = "{truelle}",
          hairline = TRUE,
          shadow = TRUE,
          subNavbar = f7SubNavbar(
            f7Flex(
              f7Back(targetId = "widget_nav"),
              f7Next(targetId = "widget_nav"),
              a(
                href = "#", 
                id = "close_app",
                class = "button button-small action-button display-flex margin-left-half", 
                f7Icon("xmark_circle")
              ),
              a(
                class = "button button-small action-button display-flex margin-left-half",
                id = "run_code_output",
                f7Icon("play")
              ),
              uiOutput("clip_button"),
              a(
                class = "button button-small display-flex margin-left-half",
                id = "theme_switch",
                f7Icon("sun_max")
              )
            )
          )
        ),
        f7Tabs(
          id = "widget_nav",
          animated = TRUE,
          f7Tab(
            tabName = "Home",
            icon = f7Icon("house"),
            active = TRUE,
            rclipboardSetup(),
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
                      $('#run_code_output').children().show();
                      $('#clip_button').show();
                    } else {
                      $('#run_code_output').children().hide();
                      $('#clip_button').hide();
                    }
                  });
                  
                  $(document).one('shiny:connected', function() {
                    var isDark = $('html').hasClass('theme-dark');
                    Shiny.setInputValue('is_dark', isDark);
                  });
                  
                  $('#theme_switch').on('click', function() {
                    var isDark = $('html').hasClass('theme-dark');
                    if (isDark) {
                      $(this).find('.f7-icons').html('moon_fill');
                      $('html').removeClass('theme-dark');
                    } else {
                      $(this).find('.f7-icons').html('sun_max');
                      $('html').addClass('theme-dark');
                    }
                    Shiny.setInputValue('is_dark', !isDark, {priority: 'event'});
                  })
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
            shinyMobile::f7Radio(
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
              selected = "golem_default",
              choices = list(
                default = list(
                  title = "golem_default",
                  subtitle = "{golem} default template",
                  text = "Best choice if you don't know where to start",
                  image = "https://raw.githubusercontent.com/ThinkR-open/golem/master/inst/rstudio/templates/project/golem.png"
                ),
                shinyMobile_simple = list(
                  title = "shinyMobile_simple",
                  subtitle = "Simplest {shinyMobile} template",
                  text = "Ideal for simple apps with one page content.",
                  image = "https://rinterface.github.io/shinyMobile/reference/figures/logo.png"
                ),
                shinyMobile_tabs = list(
                  title = "shinyMobile_tabs",
                  subtitle = "Tabs layout for {shinyMobile}",
                  text = "Ideal for complex apps with multi tabs content.
                  Perfect for mobile devices.",
                  image = "https://rinterface.github.io/shinyMobile/reference/figures/logo.png"
                ),
                shinyMobile_split = list(
                  title = "shinyMobile_split",
                  subtitle = "Split layout for {shinyMobile}",
                  text = "Ideal for complex apps with multi tabs content.
                  Perfect for larger mobile devices such as tablets.",
                  image = "https://rinterface.github.io/shinyMobile/reference/figures/logo.png"
                )
              )
            )
          ),
          f7Tab(
            tabName = "Output",
            icon = f7Icon("document_text"),
            aceEditor(
              outputId = "code_output",
              value = "",
              mode = "r"
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

