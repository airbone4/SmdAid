#' my knit.
#'
#' render to sub folder report
#' 需要這個函數是因為,_site.yml 裡面的輸出目錄,會被優先指定。而且好像
#' 文件中的output_dir也無用。
#'
#' @export
#'

myknit<-function(inputFile, encoding='UTF-8',output_dir="report",...){
message("We are using Smdaid.")
    if (file.exists("profile.do"))
        file.remove("profile.do")
    srcDir<-dirname(inputFile)
    ifelse(!dir.exists(file.path(srcDir, output_dir)), dir.create(file.path(srcDir, output_dir)), FALSE)
    ofile <- rmarkdown::render(inputFile,
                               encoding=encoding,
                               envir=new.env(),
                               output_dir = "report")
}

