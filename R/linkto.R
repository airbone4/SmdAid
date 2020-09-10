
#' linkto().
#'
#' outposix=linkto() 將函數linkto() 的結果作為參數放在options@outposix
#'
#' @export
#'

# outposix=linkto() 將函數linkto() 的結果作為參數放在options@outposix
linkto<-function(ext,title)
{
  #stata_png<-paste0(stata_pre,",png,外部連結")

  return (paste0(stata_pre,",",ext,",",title))
}
