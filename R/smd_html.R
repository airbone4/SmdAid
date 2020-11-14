
#' Title
#' 如果不指定template,那就使用本套裝預設的template
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
smd_html<-function(...){

dlog('smd_html',"render function")

    #cat(paste0(args),file="c:/temp/xx1.txt",sep="\n",append = T)
    #mylog(args)
    css<-c(system.file("rmarkdown/templates/report/resources/mystyle.css", package = "SmdAid"),
           system.file("rmarkdown/templates/report/resources/bluetable.css", package = "SmdAid"))
    #rmarkdown::html_document(...,css=css,extra_dependencies=SmdAid_dependencies(),encoding="UTF-8")
    args<-list(...)
    argnames<-names(args)

    if (! "template" %in% argnames){
      smdtemplate<-system.file("htmldependencies/lib/smdaid-0.0.0.2020/template/smddefault.html", package="SmdAid")
      rmarkdown::html_document(...,
                               extra_dependencies=SmdAid_dependencies(),
                               encoding="UTF-8",
                               template=smdtemplate)

    }
    else
      rmarkdown::html_document(...,
                               extra_dependencies=SmdAid_dependencies(),
                               encoding="UTF-8")


}


