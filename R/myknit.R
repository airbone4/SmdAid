
#' Title myknit.
#'
#' render to sub folder report
#' 這個函數會先檢查指定的output_dir是不是存在,
#' 問題是,這個output_dir 有用到嗎?
#'
#' 需要這個函數是因為,_site.yml 裡面的輸出目錄,會被優先指定。而且好像
#' 文件中的output_dir也無用。
#'
#' @param inputFile
#' @param encoding
#' @param output_dir  rmarkdown好像會自己切換到RMD的目錄當作「工作目錄」。
#' 因此,這裡的output_dir 是指RMD所在的【子目錄】。
#' @param ...
#'
#' @return
#' @export
#' @examples


# 測試過rmarkdown::html_document(pandoc_args = "--self-contained"),

myknit<-function(inputFile, encoding='UTF-8',output_dir="",...){
# message("We are using Smdaid.")
    message("應該用不到這個函數myknit()了?")
    if (file.exists("profile.do"))
        file.remove("profile.do")
    # 下面這行都是無效
    # 看看這裡:https://stackoverflow.com/questions/39885363/importing-common-yaml-in-rstudio-knitr-document
    if(output_dir=="")
        output_dir = rmarkdown::metadata$output_dir

    if(length(output_dir)==0 || output_dir=="")
        output_dir = "report"
    dlog(output_dir,title="html output folder")
        #outpout_dir="report"


    # 檢查指定的output_dir是不是存在,問題是,這個output_dir 有用到嗎?
    message(paste0("STATA輸出到",output_dir))
    # rmarkdown好像會自己切換到RMD的目錄當作工戶目錄。因此,這裡乾脆
    # 用的是輸入RMD的目錄,
    srcDir<-dirname(inputFile)
    if(!dir.exists(file.path(srcDir, output_dir)))
       dir.create(file.path(srcDir, output_dir))
    ofile <- rmarkdown::render(inputFile,
                               encoding=encoding,
                               envir=new.env(),
                               output_dir =output_dir,
                               ...)
}

