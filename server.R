# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(datasets)
#p = 'SELECT bytes/(1024*1024*1024) as MB,filename,date  FROM world.serverdata where filename like '+input$region

mydb = dbConnect(MySQL(), user='root', password='raj-12345678', dbname='world', host='localhost')
k = dbGetQuery(mydb,'SELECT bytes/(1024*1024*1024) as MB,filename,date  FROM world.serverdata where filename like "/%/%/";')
#k = dbGetQuery(mydb,p)


#pon = paste("SELECT bytes/(1024*1024*1024) as MB,filename,date from world.serverdata where filename like '",input$region,"'",sep="")
#t = dbGetQuery(mydb,pon)
#print(head(t, n = 3))

#Define a server for the Shiny app
function(input, output) {
  output$phonePlot <- renderPlot({
    pon = paste("SELECT Round(bytes/(1024*1024*1024),3) as GB,filename,date from world.serverdata where filename like '",input$region,"'",sep="")
    max = paste("SELECT MAX(bytes/(1024*1024*1024)) as MAX_MB from world.serverdata where filename like '",input$region,"'",sep="")
    min = paste("SELECT MIN(bytes/(1024*1024*1024)) as MIN_MB from world.serverdata where filename like '",input$region,"'",sep="")
    t = dbGetQuery(mydb,pon)
    max_val = dbGetQuery(mydb,max) 
    min_val = dbGetQuery(mydb,min)
    max_bytes = max_val[1,"MAX_MB"]
    min_bytes = max_val[1,"MIN_MB"]
    plot(t[,"GB"],type = "o",col = "red", xlab = "Month", ylab = "Space Usage in GB",main = input$region, axes = TRUE, frame = TRUE, xaxt = "n")
    label_x <- t[,"date"]
    axis(1,at = seq(1, length(label_x), by=1),label_x)
  })

  output$line <- renderPlot({
    v <- c(7,12,28,3,41)
    plot_data = paste("SELECT ROUND(bytes/(1024*1024*1024),3) as GB,filename,date from world.gencore where filename like '",input$region2,"'",sep="")
    t = dbGetQuery(mydb,plot_data)
    plot(t[,"GB"],type = "o",col = "red", xlab = "Month", ylab = "Space Usage in GB",main = input$region2, axes = TRUE, frame = TRUE, xaxt = "n")
    label_x <- t[,"date"]
    axis(1,at = seq(1, length(label_x), by=1),label_x)
  })

  
output$view <- renderTable({
    po = paste("SELECT bytes/(1024*1024*1024) as GB,filename,date from world.serverdata where filename like '",input$region,"'",sep="")
    t2 = dbGetQuery(mydb,po)
    head(t2, n = 6)
  },width = '100%',digits=3,align = 'c',striped = TRUE,  hover = TRUE, bordered = TRUE)

output$view2 <- renderTable({
  po = paste("SELECT ROUND(bytes/(1024*1024*1024),3) as GB,filename,date from world.gencore where filename like '",input$region2,"'",sep="")
  t2 = dbGetQuery(mydb,po)
  head(t2, n = 6)
},,width = '100%',digits=3,align = 'c',striped = TRUE,  hover = TRUE, bordered = TRUE)
}