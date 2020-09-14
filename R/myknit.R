#' my knit.
#'
#' render to sub folder report
#'
#' @export
#'

myknit<-function(inputFile, encoding='UTF-8',output_dir="report"){

    if (file.exists("profile.do"))
        file.remove("profile.do")
    srcDir<-dirname(inputFile)
    ifelse(!dir.exists(file.path(srcDir, output_dir)), dir.create(file.path(srcDir, output_dir)), FALSE)

        ofile <- rmarkdown::render(inputFile, encoding=encoding, envir=new.env(),output_dir = "report")
}

