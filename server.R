mydb = dbConnect(MySQL(), user='root', password='raj-12345678', dbname='world', host='localhost')

#Define a server for the Shiny app
function(input, output) {
  output$phonePlot <- renderPlot({
    pon = paste("SELECT Round(bytes/(1024*1024*1024),3) as GB,filename,date from world.serverdata where filename like '",input$region,"'",sep="")
    t = dbGetQuery(mydb,pon)
    plot(t[,"GB"],type = "o",col = "red", xlab = "Month", ylab = "Space Usage in GB",main = input$region, axes = TRUE, frame = TRUE, xaxt = "n")
    label_x <- t[,"date"]
    axis(1,at = seq(1, length(label_x), by=1),label_x)
  })

  output$line <- renderPlot({
    plot_data = paste("SELECT ROUND(bytes/(1024*1024*1024),3) as GB,filename,date from world.gencore where filename like '",input$region2,"'",sep="")
    t = dbGetQuery(mydb,plot_data)
    plot(t[,"GB"],type = "o",col = "red", xlab = "Month", ylab = "Space Usage in GB",main = input$region2, axes = TRUE, frame = TRUE, xaxt = "n")
    label_x <- t[,"date"]
    axis(1,at = seq(1, length(label_x), by=1),label_x)
  })

  
output$view <- renderTable({
    po = paste("SELECT bytes/(1024*1024*1024) as GB,filename,date from world.serverdata where filename like '",input$region,"' order by date desc",sep="")
    t2 = dbGetQuery(mydb,po)
    head(t2, n = 6)
  },width = '100%',digits=3,align = 'c',striped = TRUE,  hover = TRUE, bordered = TRUE)

output$view2 <- renderTable({
  po = paste("SELECT ROUND(bytes/(1024*1024*1024),3) as GB,filename,date from world.gencore where filename like '",input$region2,"' order by date desc",sep="")
  t2 = dbGetQuery(mydb,po)
  head(t2, n = 6)
},width = '100%',digits=3,align = 'c',striped = TRUE,  hover = TRUE, bordered = TRUE)
}