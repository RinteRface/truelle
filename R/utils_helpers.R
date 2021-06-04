pkg_description_fields <- list(
  pkg_name = "shinyexample", # The Name of the package containing the App 
  pkg_title = "PKG_TITLE", # The Title of the package containing the App 
  pkg_description = "PKG_DESC.", # The Description of the package containing the App 
  author_first_name = "AUTHOR_FIRST", # Your First Name
  author_last_name = "AUTHOR_LAST",  # Your Last Name
  author_email = "AUTHOR@MAIL.COM",      # Your Email
  repo_url = NULL
)

usethis_commons <- list(
  license = '  usethis::use_mit_license( "Golem User" )',  
  readme = "  usethis::use_readme_rmd( open = FALSE )",
  coc = "  usethis::use_code_of_conduct()",
  lifecycle = '  usethis::use_lifecycle_badge( "Experimental" )',
  news = "  usethis::use_news_md( open = FALSE )",
  data = "  usethis::use_data_raw()",
  git = "  usethis::use_git()"
)


webdev_commons <- list(
  input_binding = paste0(
    "  golem::add_js_input_binding( \n",
    '   "myInputBinding", \n',
    "   initialize = FALSE, \n", 
    "   dev = FALSE, \n", 
    '   events = list(name = "click", rate_policy = FALSE) \n',
    "  )", 
    collapse = "\n"
  ),
  output_binding = '  golem::add_js_output_binding("myOutputBinding")',
  js_handler = '  golem::add_js_handler("script")',
  simple_js = '  golem::add_js_file("script")',
  simple_css = '  golem::add_css_file("custom")'
)

jobs <- list()

run_text <- function(code) eval(parse(text = code))


# dropNulls
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}

# transform list to char
list_2_char <- function(l, prefix, input) {
  temp <- lapply(seq_along(l), function(i) {
    if (input[[paste0(prefix, names(l)[[i]])]]) {
      l[[i]]
    }
  }) %>% 
    dropNulls() %>%
    paste0(collapse = "\n")
  
  if (nchar(temp) > 0) temp <- paste0(temp, "\n \n", collapse = "\n")
  temp
}


# Copy a file template to the R folder to
# replace the default app_ui.R provided by {golem}
add_ui_template <- function(template) {
  
  pkg_to_import <- strsplit(template, "_")[[1]][1]
  
  paste0(
    '  unlink("R/app_ui.R", TRUE, TRUE) \n',
    '  file.copy( \n',
    '   system.file( \n',
    '    "templates_ui/', template, '.R", \n', 
    '    package = "truelle" \n',
    '   ), \n',
    '   "R/app_ui.R" \n',
    '  ) \n',
    '  unlink("R/app_server.R", TRUE, TRUE) \n',
    '  file.copy( \n',
    '   system.file( \n',
    '    "templates_server/', template, '.R", \n', 
    '    package = "truelle" \n',
    '   ), \n',
    '   "R/app_server.R" \n',
    '  ) \n',
    if (pkg_to_import != "golem") '  usethis::use_package("', pkg_to_import, '") \n',
    '  devtools::document() \n',
    collapse = "\n"
  )
}


#' Modified Framework7 radio input
#'
#' \code{f7Radio} creates a radio button input.
#'
#' @param inputId Radio input id.
#' @param label Radio label
#' @param choices List of choices. Must be a nested list. 
#' @param selected Selected element. NULL by default.
#'
#' @export
#' @rdname radio
f7Radio <- function(inputId, label, choices = NULL, selected = NULL) {
  
  shiny::tagList(
    shiny::tags$div(
      class = "block-title",
      label
    ),
    shiny::tags$div(
      class = "list media-list shiny-input-radiogroup",
      id = inputId,
      createRadioOptions(choices, selected, inputId)
    )
  )
  
}


#' Generates a list of option for \link{f7Radio}
#'
#' @param choices List of choices.
#' @param selected Selected value
#' @param inputId Radio input id.
#'
#' @keywords internal
createRadioOptions <- function(choices, selected, inputId) {
  titles <- unlist(lapply(seq_along(choices), function (c) choices[[c]]$title))
  selectedPosition <- if (!is.null(selected)) match(selected, titles) else NULL
  
  choicesTag <- lapply(X = seq_along(choices), function(i) {
    shiny::tags$li(
      shiny::tags$label(
        class = "item-radio item-radio-icon-start item-content",
        shiny::tags$input(
          type = "radio",
          name = inputId,
          value = choices[[i]]$title
        ),
        shiny::tags$i(class = "icon icon-radio"),
        shiny::tags$div(
          class = "item-inner",
          shiny::tags$div(
            class = "item-title-row",
            shiny::tags$div(class="item-title", choices[[i]]$title),
            shiny::tags$div(
              class = "item-after item-media",
              choices[[i]]$image
            )
          ),
          shiny::tags$div(class = "item-subtitle", choices[[i]]$subtitle),
          shiny::tags$div(class = "item-text", choices[[i]]$text)
        )
      )
    )
  })
  
  if (!is.null(selected)) choicesTag[[selectedPosition]]$children[[1]]$children[[1]]$attribs[["checked"]] <- NA
  
  shiny::tags$ul(choicesTag)
}


# Custom clipboard button
rclipButton <- function (inputId, label, clipText, icon = NULL, modal = FALSE) 
{
  
  el <- a(
    id = inputId,
    class = "button button-small action-button display-flex margin-left-half",
    tagList(label, icon)
  )
  el$attribs$`data-clipboard-text` <- clipText
  tagList(
    el, 
    if (modal) {
      tags$script(
        sprintf(
          "new ClipboardJS(\".button\", { container: document.getElementById(\"%s\") } ); ", 
          inputId
        )
      )
    }
    else {
      tags$script(
        sprintf(
          "new ClipboardJS(\".button\", document.getElementById(\"%s\") );", 
          inputId
        )
      )
    }
  )
}