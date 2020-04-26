files = list.files(path='C:/Users/choud/OneDrive/Desktop/ShinyData/gencoreAudit')

chr <- 'C:/Users/choud/OneDrive/Desktop/ShinyData/gencoreAudit/'
file_location = paste(chr,files,sep="")


for (i in files){print(substr(i, 14, 23))}

data2=lapply(file_location,read.csv, header=FALSE, sep="\t")

for (i in 1:length(data2))
{
  data2[[i]]<-cbind(data2[[i]],substr(files[i],14,23))
}

data_rbind <- do.call("rbind", data2)
colnames(data_rbind)[c(1,2,3)]<-c("bytes", "filename", "date")

mydb = dbConnect(MySQL(), user='root', password='raj-12345678', dbname='world', host='localhost')
dbWriteTable(mydb,value = data_rbind,row.names = FALSE,name = "gencore",append = TRUE)



