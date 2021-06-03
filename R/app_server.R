#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinyMobile
#' @importFrom shinyAce updateAceEditor
#' @importFrom callr r_bg
#' @importFrom jsonlite toJSON 
#' @noRd
app_server <- function( input, output, session ) {
  
  # Tooltip for golem option
  observeEvent({
    req(input$engine_type)
  }, {
    addF7Tooltip(
      selector = "#engine_type > ul > li:nth-child(1) > label > div > div",
      options = list(
        text = "{golem} allows to develop production ready shiny apps ..."
      )
    )
  })
  
  
  observeEvent(input$project_type, {
    session$sendCustomMessage("toggle_project_type", input$project_type)
  })
  
  observeEvent(c(input$package_path, input$project_type), {
    cond <- (input$project_type != "placeholder" && nchar(input$package_path) > 0)
    session$sendCustomMessage(
      "toggle_run_button", 
      toJSON(cond, auto_unbox = TRUE)
    )
  })
  
  observeEvent(input$widget_nav,{
    if (input$project_type == "placeholder" && (
      input$widget_nav == "Configuration" || 
      input$widget_nav == "Output"
    )) {
      f7Toast(
        text = "You can't do this now.", 
        position = "center"
      )
    }
  })
  
  observeEvent(input$project_type, {
    choices <- if (input$project_type == "package") {
      c(
        "{golem}" = "golem", 
        "{packer}" = "packer",
        "{reactR}" = "reactr"
      )
    }
    updateF7Radio("engine_type", choices = choices)
  })
  
  #observeEvent(input$engine_type, {
  #  updateF7Tabs("widget_nav", selected = "Configuration")
  #})
  
  output$config_steps <- renderUI({
    req(input$engine_type)
    steps <- if (input$engine_type == "golem") {
      f7Block(
        inset = TRUE, 
        f7AccordionItem(
          title = div(class = "text-color-blue", "Package path"),
          open = TRUE, 
          f7Text(
            inputId = "package_path", 
            label = "", 
            value = "", 
            placeholder = "package path"
          )
        ),
        f7AccordionItem(
          title = div(class = "text-color-blue", "Metadata"),
          f7Block(
            inset = TRUE, 
            strong = TRUE,
            f7Toggle(
              inputId = "edit_description", 
              label = "Edit description", 
              checked = FALSE
            )
          )
        ),
        f7AccordionItem(
          title = div(class = "text-color-blue", "{usethis} commons"),
          # common usethis tasks
          lapply(seq_along(usethis_commons), function(i) {
            f7Block(
              inset = TRUE, 
              strong = TRUE,
              f7Toggle(
                inputId = paste0("set_usethis_", names(usethis_commons)[[i]]),
                label = names(usethis_commons)[[i]],
                checked = TRUE
              ),
              br()
            )
          })
          
        ),
        # Bug with interactivity... check what we can do ...
        #f7AccordionItem(
        #  title = "{testthat} commons",
        #  f7Toggle(
        #    inputId = "allow_recommended_tests", 
        #    label = "Recommanded tests", 
        #    checked = FALSE
        #  )
        #),
        f7AccordionItem(
          title = div(class = "text-color-blue", "Dependencies"),
          f7Block(
            inset = TRUE, 
            strong = TRUE,
            f7Toggle(
              inputId = "use_recommended_deps", 
              label = "Add recommended deps", 
              checked = TRUE
            )
          )
        ),
        f7AccordionItem(
          title = div(class = "text-color-blue", "{golem} utils"),
          f7Block(
            inset = TRUE, 
            strong = TRUE,
            f7Toggle(
              inputId = "use_golem_utils", 
              label = "Allow utils", 
              checked = TRUE
            )
          )
        ),
        f7AccordionItem(
          title = div(class = "text-color-blue", "Shiny modules"),
          f7Block(
            inset = TRUE, 
            strong = TRUE,
            f7Toggle(
              inputId = "add_module_skeleton", 
              label = "Add module", 
              checked = TRUE
            )
          )
        ),
        f7AccordionItem(
          title = div(class = "text-color-blue", "Web dev tools"),
          lapply(seq_along(webdev_commons), function(i) {
            f7Block(
              inset = TRUE, 
              strong = TRUE,
              f7Toggle(
                inputId = paste0("create_golem_", names(webdev_commons)[[i]]),
                label = names(webdev_commons)[[i]],
                checked = TRUE
              ),
              br()
            )
          }),
          f7TextArea(
            inputId = "css_template",
            label = "CSS template",
            value = paste0(
              "function(path, ...){ \n",
              "    # Define a CSS template \n",
              "    write_there <- function(...){ \n",
              "      write(..., file = path, append = TRUE) \n",
              "    } \n",
              
              '    write_there("body {") \n',
              '    write_there("    background-color:red;") \n',
              '    write_there("}") \n',
              "   }",
              collapse = "\n"
            )
          ),
          f7TextArea(
            inputId = "js_template",
            label = "JS template",
            value = NULL
          )
        ),
        f7AccordionItem(
          title = div(class = "text-color-blue", "Other options"),
          f7Block(
            inset = TRUE, 
            strong = TRUE,
            f7Toggle(
              inputId = "set_golem_options",
              label = "Golem options",
              checked = FALSE
            )
          )
        )
      ) 
    }
    if (!is.null(steps)) {
      tagList(
        f7Accordion(
          id = "config_step",
          multiCollapse = TRUE,
          steps
        ),
        f7Card(
          title = "Customize {golem} hooks",
          p("Enter any extra configuration you want to have in your
            project", class = "text-color-blue"),
          br(),
          f7TextArea(
            inputId = "custom_golem_hook",
            label = "Custom hook",
            value = NULL
          )
        )
      )
    }
  })
  
  # End-user info for package path
  observeEvent({
    input$package_path
  }, {
    validateF7Input(
      inputId = "package_path",
      pattern = "*",
      info = "Package path like ~/Desktop/myPackage",
      error = "Path cannot be empty!"
    )
  })
  
  observeEvent({
    input$custom_golem_hook
  }, {
    validateF7Input(
      inputId = "custom_golem_hook",
      info = "A {golem} hook is a function run at package creation.",
    )
  })
  
  # Insert text description fields if enabled
  observeEvent(input$edit_description, {
    if (input$edit_description) {
      insertUI(
        selector = "#edit_description",
        where = "afterEnd",
        ui = div(
          id = "package_description_div",
          lapply(seq_along(pkg_description_fields), function(i) {
            f7Text(
              inputId = names(pkg_description_fields)[[i]],
              label = strsplit(names(pkg_description_fields)[[i]], "_")[[1]][2],
              value = pkg_description_fields[[i]]
            )
          })
        )
      )
    } else {
      removeUI("#package_description_div")
    }
  })
  
  # Update custom hook based on many options
  observeEvent({
    req(input$engine_type == "golem")
    req(input$package_path)
    c(
      input$package_path,
      input$edit_description,
      input$set_golem_options,
      #input$allow_recommended_tests,
      input$use_golem_utils,
      input$use_recommended_deps,
      input$add_module_skeleton,
      input$css_template,
      input$js_template,
      input$selected_template,
      eval(parse(text = paste0("input$create_golem_", names(webdev_commons)))),
      eval(parse(text = paste0("input$set_usethis_", names(usethis_commons)))),
      eval(parse(text = paste0("input$", names(pkg_description_fields))))
    )
  }, 
  {
    if (nchar(input$css_template) > 0) {
      webdev_commons[["simple_css"]] <- paste0(
        '  golem::add_css_file( \n',
        '   "custom_css", \n',
        "   template = ", input$css_template, "\n",
        '  )',
        collapse = "\n"
      )
    }
    
    if (nchar(input$js_template) > 0) {
      webdev_commons[["simple_js"]] <- paste0(
        '  golem::add_js_file( \n',
        '   "custom_js", \n',
        "   template = ", input$js_template, "\n",
        '  )',
        collapse = "\n"
      )
    }
    
    web_dev_tasks <- list_2_char(webdev_commons, "create_golem_", input)
    usethis_tasks <- list_2_char(usethis_commons, "set_usethis_", input)
    
    temp_val <- paste0(
      "function(path, package_name, ...) { \n",
      if (input$edit_description) {
        paste0(
          '  golem::fill_desc( \n',
          '   pkg_name = "', input[[names(pkg_description_fields)[[1]]]], '", \n', 
          '   pkg_title = "', input[[names(pkg_description_fields)[[2]]]], '", \n', 
          '   pkg_description = "', input[[names(pkg_description_fields)[[3]]]], '", \n',
          '   author_first_name = "', input[[names(pkg_description_fields)[[4]]]], '", \n',
          '   author_last_name = "',  input[[names(pkg_description_fields)[[5]]]],'", \n',
          '   author_email = "', input[[names(pkg_description_fields)[[6]]]], '", \n',
          '   repo_url = "', input[[names(pkg_description_fields)[[7]]]], '" \n',
          '  ) \n',
          '\n',
          collapse = "\n"
        )
      },
      if (input$set_golem_options) "  golem::set_golem_options() \n",
      usethis_tasks, 
      #if (input$allow_recommended_tests) "  golem::use_recommended_tests() \n",
      if (input$use_recommended_deps) "  golem::use_recommended_deps() \n",
      if (input$use_golem_utils) {
        paste0(
          "  golem::use_utils_ui() \n", 
          "  golem::use_utils_server() \n",
          "\n",
          collapse = "\n"
        )
      },
      if (input$add_module_skeleton) {
        paste0(
          '  golem::add_module( name = "my_first_module" ) \n',
          '  golem::add_fct("my_first_module") \n',
          '  golem::add_utils("my_first_module") \n',
          '\n',
          collapse = "\n"
        )
      },
      web_dev_tasks,
      if (input$selected_template != "golem_default") {
        add_ui_template(input$selected_template)
      },
      " }",
      collapse = "\n"
    )
    
    updateF7TextArea(
      inputId = "custom_golem_hook",
      value = temp_val
    )
  })
  
  # Update aceEditor with golem commands
  observeEvent(
    c(
      input$package_path,
      input$custom_golem_hook
    ), {
      req(nchar(input$package_path) > 0)
      
      hook <- if (nchar(input$custom_golem_hook) > 0) {
        input$custom_golem_hook
      } else {
        "golem::project_hook"
      }
      
      new_val <- paste0(
        'golem::create_golem( \n',
        ' path = "', input$package_path, '", \n',
        ' open = FALSE, \n', 
        ' project_hook = ', hook,' \n',
        ')',
        collapse = "\n"
      )
      
      updateAceEditor(
        session, 
        "code_output",
        value = new_val
      )
    })
  
  # Copy to clipboard
  output$clip_button <- renderUI({
    rclipButton(
      "copy_code_output", 
      div(style = "padding-right: 5px", "Copy code"),  
      input$code_output, 
      icon = f7Icon("camera")
    )
  })
  
  
  # Run the command in another process
  observeEvent(input$run_code_output, {
    jobs[[1]] <- r_bg(run_text, args = list(code = input$code_output))
    jobs[[1]]$wait()
    
    f7Notif(
      title = "Hey!",
      paste("Package successfully created at", jobs[[1]]$get_result()),
      icon = f7Icon("info_round")
    )
  })
  
  # Close the app
  observeEvent(input$close_app, {
    f7Dialog(
      id = "close_app_confirm", 
      title = "Oupps",
      text = "Do you really want to close?", 
      type = "confirm"
    )
  })
  
  observeEvent(input$close_app_confirm, {
    req(input$close_app_confirm)
    stopApp()
  })
  
  #observeEvent(input$project_type, once = TRUE, {
  #  updateF7Accordion("config_step", selected = 2)
  #})
}
