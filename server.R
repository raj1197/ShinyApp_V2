# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(datasets)
#p = 'SELECT bytes/(1024*1024*1024) as MB,filename,date  FROM world.serverdata where filename like '+input$region

mydb = dbConnect(MySQL(), user='root', password='raj-12345678', dbname='world', host='localhost')
k = dbGetQuery(mydb,'SELECT bytes/(1024*1024*1024) as MB,filename,date  FROM world.serverdata where filename like "/%/%/";')
#k = dbGetQuery(mydb,p)

#Define a server for the Shiny app
function(input, output) {
  #p = "SELECT bytes/(1024*1024*1024) as MB,filename,date  FROM world.serverdata where filename like "+ input$region
  #t = reactive(paste("SELECT filename,date  FROM world.serverdata where filename like ", "hello"))
  #t = reactive(input$region)
  # p = paste("SELECT filename,date  FROM world.serverdata where filename like ",renderText(input$region),sep = " ")
  # Fill in the spot we created for a plot
  #t = "hello"
  output$phonePlot <- renderPlot({
    pon = paste("SELECT bytes/(1024*1024*1024) as MB,filename,date from world.serverdata where filename like '",input$region,"'",sep="")
    max = paste("SELECT MAX(bytes/(1024*1024*1024)) as MAX_MB from world.serverdata where filename like '",input$region,"'",sep="")
    min = paste("SELECT MIN(bytes/(1024*1024*1024)) as MIN_MB from world.serverdata where filename like '",input$region,"'",sep="")
    t = dbGetQuery(mydb,pon)
    max_val = dbGetQuery(mydb,max) 
    min_val = dbGetQuery(mydb,min)
    max_bytes = max_val[1,"MAX_MB"]
    min_bytes = max_val[1,"MIN_MB"]
    print(pon)
    barplot(t[,"MB"], 
            main=input$region,
            ylab="Space Used in MB",
            xlab=pon,
            ylim=range(pretty(c(0, max_bytes*1.10))))
  })
}