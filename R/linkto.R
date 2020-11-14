#' linkto().這個函數其實是輔助outposix,用來產生outposix需要的參數,
#'
#' outposix=linkto() 將函數linkto() 的結果作為參數放在options@outposix
#'
#' 需要改進:
#' 1) 這個函數有需要改進的地方,用到了總體變數stata_pre
#' 2) 應該採用yaml
#'
#' @export
#'


# outposix=linkto() 將函數linkto() 的結果作為參數放在options@outposix
# 用逗點分隔成3部分
linkto<-function(ext,title)
{
  #stata_png<-paste0(stata_pre,",png,外部連結")

  return (paste0(stata_pre,",",ext,",",title))
}

#'
#' @export
#'

linkto2<-function(pre,ext,title)
{
  return (paste0(pre,",",ext,",",title))

}

