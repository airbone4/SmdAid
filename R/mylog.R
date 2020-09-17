
mylog<-function(...){
  args<-list(...)
  filename <-"c:/temp/xxx2.txt"
  write.table(args, file = filename, sep = ",", row.names = F,
              col.names = T, quote = T, append = T)
}
