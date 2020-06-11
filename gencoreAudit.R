# setting the present working directory for the file
#setwd('C:/ShinyApp')
source('config.R')

# Reading all the files that have to be inserted into the database 
data_location = paste(toString(getwd()),'/data/gencoreAudit/',sep="")
files = list.files(path=data_location)
file_location = paste(data_location,files,sep="")

for (i in files){print(substr(i, 14, 23))}

data2=lapply(file_location,read.csv, header=FALSE, sep="\t")

for (i in 1:length(data2))
{
  data2[[i]]<-cbind(data2[[i]],substr(files[i],14,23))
}

data_rbind <- do.call("rbind", data2)
colnames(data_rbind)[c(1,2,3)]<-c("bytes", "filename", "date")

# writing data to the database
dbWriteTable(mydb,value = data_rbind,row.names = FALSE,name = "gencore",append = TRUE)
