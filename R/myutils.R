# 抽取第1個字元是#開頭
divtitle<-function (str){
  if(grepl("^[#]* ",str)) {
    rst<-sub("(^[#]* )(.*$)","\\1 <span class='outposix'> \\2 </span>  \n\n",str, perl=TRUE)
  }else{
    rst<-paste0("<span class='outposix'>",str,"</span>   \n\n")
  }

}

dlog<-function(any,title="empty"){
  print(paste0("----- ",title, " ------"))
  print(any)
  print("-------------")
}
