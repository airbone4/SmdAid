#' Provide HTML dependencies
#'
#' These functions provide HTML dependencies for `clipboard.js`,
#' @name html_dependencies
#' @return An object that can be included in a list of dependencies passed to
#' [htmltools::attachDependencies()][htmltools::htmlDependencies].
#' @family HTML dependencies functions
NULL

#' @rdname html_dependencies
#' @export
html_dependency_clipboard <- function() {
  htmltools::htmlDependency(
    name = 'clipboard',
    version = '1.7.1',
    src = c(
      file = 'htmldependencies/lib/clipboard-1.7.1',
      href = 'https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/1.7.1/'
    ),
    script = 'clipboard.min.js',
    package = 'SmdAid'
  )
}

#' @rdname html_dependencies
#' @export
html_dependency_allcodecopy <- function() {
  htmltools::htmlDependency(
    name = 'allcodecopy',
    version = '0.0.0.2020',
    src = 'htmldependencies/lib/smdaid-0.0.0.2020',
    script = 'js/collectCopy.js',
    stylesheet = c('css/twowaytable.css','css/mystyle.css'),
    package = 'SmdAid',
    all_files = FALSE
  )
}

#' List SmdAid dependencies
#'
#' This function is used to get the list of `SmdAid` dependencies.
#'
#' @return A list of dependencies that can be passed to
#' [htmltools::attachDependencies()][htmltools::htmlDependencies] or
#' [rmarkdown::html_document_base()].
#' @family HTML dependencies functions
#' @export
SmdAid_dependencies <- function() {
  list(html_dependency_clipboard(),
       html_dependency_allcodecopy()
  )
}
