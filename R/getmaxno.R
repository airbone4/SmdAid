#' getmaxno 用來找stata 輸出的檔案,利用指定的型態,
#' 在chunk 執行之前,找出目前的最大號碼,例如3,在chunk 執行之後
#' 如果發現大於3的號碼,都會被認為是stata chunk產生的檔案,然後連結.
#' @pattern : 就是檔案型態,用來找最大號碼
#' @ext : 目前支援的附檔名有:png,html,docx
#' @adir: 相對於「工作目錄(就是RMD所在目錄)」的子目錄。

getmaxno<-function(pattern,ext,adir="report/"){
  #library(stringr)

  wd<-paste0(getwd(),"/",adir)
  # cat(paste0("======>",wd),sep="\n")
  list <- list.files(wd, "*" );
  # what 是表達式
  what<-paste0("(?<=",pattern,"_).*(\\d)+","(?=\\.",ext,")");
  # 找出pattern 後面的數字
  r1<-stringr::str_extract(list,what)
  # 應該要有+號吧?之前沒有
  idxlist<-as.integer(stringr::str_extract(r1,"\\d+$"))
  idxlist<-idxlist[!is.na(idxlist)];
   if(length(idxlist)==0)
     return(0)
   else{
     no<-max(idxlist,na.rm=TRUE);
     return(no)
   }


}
