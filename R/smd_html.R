#' my knit.
#'
#' render to sub folder report
#'
#' @export
#'


smd_html<-function(...){


    css<-c(system.file("rmarkdown/templates/report/resources/mystyle.css", package = "SmdAid"),
           system.file("rmarkdown/templates/report/resources/bluetable.css", package = "SmdAid"))
    #rmarkdown::html_document(...,css=css,extra_dependencies=SmdAid_dependencies(),encoding="UTF-8")
    rmarkdown::html_document(...,extra_dependencies=SmdAid_dependencies(),encoding="UTF-8")
}


