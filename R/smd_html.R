#' my knit.
#'
#' render to sub folder report
#'
#' @export
#'


smd_html<-function(...,output_dir="report"){

    if (file.exists("profile.do"))
        file.remove("profile.do")


    library(Statamarkdown)
    knitr::knit_hooks$set(
        #before : 是否是chunk處理之前
        outposix = function(before, options, envir) {

            getmaxno<-function(pattern,ext){
                library(stringr)
                wd<-paste0(getwd(),"/report/")
                # cat(paste0("======>",wd),sep="\n")
                list <- list.files(wd, "*" );
                # cat(list,sep="\n")
                what<-paste0("(?<=",pattern,"_).*","(?=\\.",ext,")");
                # cat(paste0("=====>",what))

                idxlist<-as.integer(str_extract(list,what));
                idxlist<-idxlist[!is.na(idxlist)];
                if(length(idxlist)==0)
                    return(0)
                else{
                    no<-max(idxlist,na.rm=TRUE);
                    return(no)
                }
            }


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
                            rst<-paste0(rst,of)
                        }
                    }
                    else if(ext=="html"){
                        for(idx in  seq(lastno+1,no)){
                            fn<-paste0(pattern,"_",idx,".",ext)
                            hhtxt<-paste(readLines(paste0("report/",fn),encoding = "UTF-8"),collapse=" ")
                            cat(fn,file="c:/temp/xx1.txt",sep="\n",append = T)
                            cat(hhtxt,file="c:/temp/xx1.txt",sep="\n",append = T)
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
                cat(txt)
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
            txt<-paste("\`\`\`stata  ",txt,"\n\`\`\` ",sep = "\n")
            return(txt)
        }
    )

    #css<-system.file("rmarkdown/templates/report/resources/bluetable.css", package = "SmdAid")
    css<-c(system.file("rmarkdown/templates/report/resources/mystyle.css", package = "SmdAid"),
           system.file("rmarkdown/templates/report/resources/bluetable.css", package = "SmdAid"))
#css<-system.file("rmarkdown/templates/report/resources/adv_r.css", package = "SmdAid")
    #css <-list(system.file("rmarkdown/templates/report/resources/adv_r.css", package = "SmdAid"),
    #    system.file("rmarkdown/templates/report/resources/mystyle.css", package = "SmdAid"),
    #    system.file("rmarkdown/templates/report/resources/bluetable.css", package = "SmdAid"))
    #rmarkdown::render(...,encoding="UTF-8",output_dir=output_dir)
    rmarkdown::html_document(...,css=css,encoding="UTF-8",output_dir=output_dir)
}

getStataLabel<-function ()
{
    chunklist<-knitr:::knit_code$get()
    #找stataChunk
    StataLabel<-unlist(lapply(chunklist,
                              function(x){
                                  chunk_opts<-attr(x,"chunk_opts")
                                  if(!is.null(chunk_opts$engine)
                                     && chunk_opts$engine=="stata")
                                      return(chunk_opts$label)
                                  else return ("");
                              }))
    return(StataLabel[StataLabel!=""])
}

getStataCode<-function ()
{
    #labs = knitr::all_labels()
    labs = getStataLabel()
    unwanted<-grepl("xx.*", labs)
    labs<-labs[!unwanted]
    #if (length(labs)!=0)
    #  labs=labs[-unwanted]
    return(labs)
}

getStataCode_oldWork<-function ()
{
    labs = knitr::all_labels()
    labs = labs[!labs %in% c("setup", "toc", "getlabels", "allcode")]
    unwanted<-grep("xx*", labs)
    unwanted<-unwanted[!is.na(unwanted)]
    if (length(unwanted)!=0)
        labs=labs[-unwanted]
    return(labs)
}


