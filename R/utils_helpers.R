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
  data = "  usethis::use_data_raw()"
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
  
  if (nchar(temp) > 0) temp <- paste0(temp, "\n")
  temp
}


# Copy a file template to the R folder to
# replace the default app_ui.R provided by {golem}
add_ui_template <- function(template_path) {
  unlink("R/app_ui.R", TRUE, TRUE)
  file.copy(
    template_path,
    "R/app_ui.R"
  )
}
