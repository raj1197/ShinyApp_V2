# This file serves as the backend and fetches data from the database

#Define a server for the Shiny app
function(input, output) {
  #Linechart for the cgscoreAudit directory
  output$phonePlot <- renderPlot({
    options(scipen=99999)
    pon = paste("SELECT Round(bytes/(1024*1024*1024),3) as TB,filename,date from serverdata where filename like '",input$region,"'",sep="")
    t = dbGetQuery(mydb,pon)
    plot(t[,"TB"],type = "o",col = "red", xlab = "Month", ylab = "Space Usage in TB",main = input$region, axes = TRUE, frame = TRUE, xaxt = "n",yaxs="i",ylim=c(0,max(t[,"TB"])*1.10))
    label_x <- t[,"date"]
    label_x = format(as.Date(label_x),format="%m-%d-%y")
    axis(1,at = seq(1, length(label_x), by=1),label_x)
  })
  # Linechart for the gencoreAudit directory
  output$line <- renderPlot({
    plot_data = paste("SELECT ROUND(bytes/(1024*1024*1024),3) as TB,filename,date from gencore where filename like '",input$region2,"'",sep="")
    t = dbGetQuery(mydb,plot_data)
    plot(t[,"TB"],type = "o",col = "red", xlab = "Month", ylab = "Space Usage in GB",main = input$region2, axes = TRUE, frame = TRUE, xaxt = "n",yaxs="i",ylim=c(0,max(t[,"TB"])*1.10))
    label_x <- t[,"date"]
    label_x = format(as.Date(label_x),format="%m-%d-%y") 
    axis(1,at = seq(1, length(label_x), by=1),label_x)
  })
  
  # Table for the cgscoreAudit directory  
  output$view <- renderTable({
    po = paste("SELECT bytes/(1024*1024*1024) as TB,filename,date from serverdata where filename like '",input$region,"' order by date desc",sep="")
    t2 = dbGetQuery(mydb,po)
    head(t2, n = 6)
  },width = '100%',digits=3,align = 'c',striped = TRUE,  hover = TRUE, bordered = TRUE)
  
  # Table for the gencoreAudit directory
  output$view2 <- renderTable({
    po = paste("SELECT ROUND(bytes/(1024*1024*1024),3) as TB,filename,date from gencore where filename like '",input$region2,"' order by date desc",sep="")
    t2 = dbGetQuery(mydb,po)
    head(t2, n = 6)
  },width = '100%',digits=3,align = 'c',striped = TRUE,  hover = TRUE, bordered = TRUE)
}
