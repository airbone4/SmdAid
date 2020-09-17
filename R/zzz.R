
#.onLoad <- function (libname, pkgname) {

  # print(".onLoad")
  # print(utils::globalVariables())

#}
# 找檔案,產生連結,我用了getwd()來知道現在在哪裡,
# 但是問題是,不見得工作目錄=檔案位置
.onAttach <- function (libname, pkgname) {
  # libname=> C:/Program Files/R/R-4.0.2/library
  # pkgname =>pkgname
  library(Statamarkdown)

  #library(Statamarkdown)
  #Statamarkdown::find_stata(F)
  knitr::knit_hooks$set(
    #before : 是否是chunk處理之前
    outposix = function(before, options, envir) {

      opts<-unlist(strsplit(options$outposix, ","));
      pattern<-opts[1];
      ext<-opts[2];
      if(length(opts)>2){
        title<-opts[3]
      }else{
        title<-""
      }
      if(before) {
        envir$stata_last_no<-getmaxno(pattern,ext);
        #cat(paste0("=======>",envir$stata_last_no),sep="\n")
      }
      else {
        lastno<-envir$stata_last_no;
        no<-getmaxno(pattern,ext);
        #cat(paste0("=====>lastno",lastno),sep="\n")
        #cat(paste0("=====>no",no),sep="\n")

        if(title=="") rst<-"***  "
        else   rst<-paste0(title,"  \n")

        if (lastno<no) {
          if(ext=="png"){
            for(idx in  seq(lastno+1,no)){
              of<-paste0("![fig](./report/",pattern,"_",idx,".",ext,"){ width=80% }  \n")
              rst<-paste0(rst,of,"\n***  \n")
            }

            #cat(rst,file="c:/temp/xx1.txt",sep="\n",append = T)
          }
          else if(ext=="html"){
            for(idx in  seq(lastno+1,no)){
              fn<-paste0(pattern,"_",idx,".",ext)
              hhtxt<-paste(readLines(paste0("report/",fn),encoding = "UTF-8"),collapse=" ")
              #cat(fn,file="c:/temp/xx1.txt",sep="\n",append = T)
              #cat(hhtxt,file="c:/temp/xx1.txt",sep="\n",append = T)
              #hhtxt<-paste(readLines(fn,encoding = "UTF-8"),collapse=" ")
              of<-paste0("[",ext," link ](./",pattern,"_",idx,".",ext,")  \n")
              rst<-paste0(rst,of)
              #rst<-paste0(rst,"<div>")
              rst<-paste0(rst,hhtxt,"\n***  \n")
              #rst<-paste0(rst,"</div>")
              #cat(rst,file="c:/temp/xx1.txt",sep="\n")
            }

          }
          else {
            for(idx in  seq(lastno+1,no)){
              of<-paste0("[",ext," link ](./",pattern,"_",idx,".",ext,")  \n")
              rst<-paste0(rst,of)
            }
          }
          return (rst)
        }
        #cat(of)

      }  #after

    }
  )



  knitr::knit_hooks$set(
    #before : 是否是chunk處理之前
    listdo = function(before, options, envir) {
      if(!before && file.exists(options$listdo)){
        txt<-paste(readLines(options$listdo,encoding="UTF-8"),sep="\n",collapse='\n')
        txt<-paste("\`\`\`stata  ",txt,"\n\`\`\` ",sep = "\n")
        txt<-paste("\n subrouting ",options$listdo," \n",txt,sep = "\n")
        #cat(txt)
        return(txt)
      }
    }
  )


  knitr::knit_hooks$set(
    #before : 是否是chunk處理之前
    listallcode = function(before, options, envir) {
      if(before) return()
      labs<-getStataLabel()
      codelist<-lapply(labs,function(x){
        return(knitr:::knit_code$get(x))
      })
      # codelist 是一個list
      txt<-paste(unlist(codelist),sep="\n",collapse='\n')
      txt<-paste("\`\`\`{.stata .SmdAidAll}  ",txt,"\n\`\`\` ",sep = "\n")
      return(txt)
    }
  )
}
