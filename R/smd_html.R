#' my knit.
#'
#' render to sub folder report
#'
#' @export
#'


smd_html<-function(...){


    css<-c(system.file("rmarkdown/templates/report/resources/mystyle.css", package = "SmdAid"),
           system.file("rmarkdown/templates/report/resources/bluetable.css", package = "SmdAid"))
    rmarkdown::html_document(...,css=css,encoding="UTF-8")
}


