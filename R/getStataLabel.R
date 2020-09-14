
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
