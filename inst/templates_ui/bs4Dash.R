#' The application User-Interface 
#' 
#' Bootstrap 4 dashboard template
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import bs4Dash
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    dashboardPage(
      title = "Basic Dashboard",
      fullscreen = TRUE,
      header = dashboardHeader(
        title = dashboardBrand(
          title = "bs4Dash",
          color = "primary",
          href = "https://www.google.fr",
          image = "https://adminlte.io/themes/AdminLTE/dist/img/user2-160x160.jpg",
        ),
        skin = "light",
        status = "white",
        border = TRUE,
        sidebarIcon = icon("bars"),
        controlbarIcon = icon("th"),
        fixed = FALSE
      ),
      sidebar = dashboardSidebar(
        skin = "light",
        status = "primary",
        elevation = 3,
        sidebarUserPanel(
          image = "https://image.flaticon.com/icons/svg/1149/1149168.svg",
          name = "Welcome Onboard!"
        ),
        sidebarMenu(
          sidebarHeader("Header 1"),
          menuItem(
            "Item 1",
            tabName = "item1",
            icon = icon("sliders")
          ),
          menuItem(
            "Item 2",
            tabName = "item2",
            icon = icon("id-card")
          )
        )
      ),
      controlbar = dashboardControlbar(
        skin = "light",
        pinned = TRUE,
        collapsed = FALSE,
        overlay = FALSE,
        controlbarMenu(
          id = "controlbarmenu",
          controlbarItem(
            title = "Item 1",
            "Item 1"
          ),
          controlbarItem(
            "Item 2",
            "Simple text"
          )
        )
      ),
      footer = dashboardFooter(
        left = a(
          href = "https://twitter.com/divadnojnarg",
          target = "_blank", "@DivadNojnarg"
        ),
        right = "2021"
      ),
      body = dashboardBody(
        tabItems(
          tabItem(
            tabName = "item1",
            tags$style("body { background-color: ghostwhite}"),
            fluidRow(
              actionButton("toggle_box", "Toggle Box"),
              actionButton("remove_box", "Remove Box", class = "bg-danger"),
              actionButton("restore_box", "Restore Box", class = "bg-success"),
              actionButton("update_box", "Update Box", class = "bg-primary")
            ),
            br(),
            box(
              title = textOutput("box_state"),
              "Box body",
              id = "mybox",
              collapsible = TRUE,
              closable = TRUE,
              plotOutput("plot")
            )
          ),
          tabItem(
            tabName = "item2",
            "Body content 2"
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

