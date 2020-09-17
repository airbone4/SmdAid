getmaxno<-function(pattern,ext){
  #library(stringr)
  wd<-paste0(getwd(),"/report/")
  # cat(paste0("======>",wd),sep="\n")
  list <- list.files(wd, "*" );
  # cat(list,sep="\n")
  what<-paste0("(?<=",pattern,"_).*","(?=\\.",ext,")");
  # cat(paste0("=====>",what))

  idxlist<-as.integer(stringr::str_extract(list,what));
  idxlist<-idxlist[!is.na(idxlist)];
  if(length(idxlist)==0)
    return(0)
  else{
    no<-max(idxlist,na.rm=TRUE);
    return(no)
  }
}
