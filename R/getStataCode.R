
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

