# This file renders the UI for the App
#mydb = dbConnect(MySQL(), user='root', password='raj-12345678', dbname='world', host='localhost')
source('config.R')
k = dbGetQuery(mydb,'SELECT * FROM serverdata where filename like "/%/%/%/%";')
filenames = dbGetQuery(mydb,'select distinct(filename) from serverdata where filename not in (select filename FROM serverdata where filename like "/%/%/%/%") order by filename')
filenames_2 = dbGetQuery(mydb,'select distinct(filename) from gencore where filename not in (select filename FROM gencore where filename like "/%/%/%/%/%/%") order by filename')

l = k[,"filename"]
li = filenames[,"filename"]
li_2 = filenames_2[,"filename"]
fluidPage(    
  
  # Give the page a title
  titlePanel("Space usage by Directory"),
  
  # Generate a row with a sidebar
  sidebarLayout
  (      
    
    # Define the sidebar with two input
    sidebarPanel(
      selectInput("region", "Directory:", 
                  choices=li),
      selectInput("region2", "Directory:", 
                  choices=li_2),
      hr(),
      helpText("Data from different directories")
    ),
    
    # Create a spot for the linechart
    mainPanel(
                plotOutput("phonePlot"),
                tableOutput("view"),
                plotOutput("line"),
                tableOutput("view2")
              )
    
  )
)