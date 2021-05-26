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
  #下面用來看找到甚麼檔案
  #dlog(paste0(list,collapse=","));
  what<-paste0("(?<=",pattern,"_).*(\\d)+","(?=\\.",ext,")");

  r1<-stringr::str_extract(list,what);
  idxlist<-as.integer(stringr::str_extract(r1,"\\d+$"));//bug fix
  idxlist<-idxlist[!is.na(idxlist)];
   if(length(idxlist)==0)
     return(0)
   else{
     no<-max(idxlist,na.rm=TRUE);
     return(no)
   }

  # what<-paste0("(?<=",pattern,"_).*","(?=\\.",ext,")");
  # idxlist<-as.integer(stringr::str_extract(list,what));
  # idxlist<-idxlist[!is.na(idxlist)];
  # if(length(idxlist)==0)
  #   return(0)
  # else{
  #   no<-max(idxlist,na.rm=TRUE);
  #   return(no)
  # }
}
