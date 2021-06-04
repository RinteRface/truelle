#' The application User-Interface 
#' 
#' Bootstrap 3 dashboard template
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinymaterial
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    material_page(
      title = "shinymaterial",
      tags$br(),
      material_row(
        material_column(
          width = 2,
          material_card(
            title = "",
            depth = 4,
            tags$p("By Cylinder"),
            material_switch(
              input_id = "facet_cyl",
              off_label = "No",
              on_label = "Yes",
              initial_value = TRUE
            ),
            tags$p("Include Trend Line"),
            material_switch(
              input_id = "trend_line",
              off_label = "No",
              on_label = "Yes"
            ),
            material_radio_button(
              input_id = "plot_theme",
              label = "Theme",
              choices = 
                c("Light" = "light",
                  "Dark" = "dark")
            )
          )
        ),
        material_column(
          width = 9,
          material_card(
            title = "Power vs Efficiency",
            depth = 4,
            plotOutput("mtcars_plot")
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

