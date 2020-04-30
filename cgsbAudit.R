files = list.files(path='C:/Users/choud/OneDrive/Desktop/ShinyData/cgsbAudit')

chr = 'C:/Users/choud/OneDrive/Desktop/ShinyData/cgsbAudit/'
file_location = paste(chr,files,sep="")

data2=lapply(file_location,read.csv, header=FALSE, sep="\t")

for (i in 1:length(data2))
{
  data2[[i]]<-cbind(data2[[i]],substr(files[i],11,20))
}
data_rbind <- do.call("rbind", data2) 
colnames(data_rbind)[c(1,2,3)]<-c("bytes", "filename", "date")

#print(data_rbind)

mydb = dbConnect(MySQL(), user='root', password='raj-12345678', dbname='world', host='localhost')
dbWriteTable(mydb,value = data_rbind,row.names = FALSE,name = "serverdatanew",append = TRUE)


