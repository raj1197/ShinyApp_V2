
# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(datasets)
# Use a fluid Bootstrap layout

mydb = dbConnect(MySQL(), user='root', password='raj-12345678', dbname='world', host='localhost')
k = dbGetQuery(mydb,'SELECT * FROM world.serverdata where filename like "/%/%/%/%";')
filenames = dbGetQuery(mydb,'select distinct(filename) from world .serverdata where filename not in (select filename FROM world.serverdata where filename like "/%/%/%/%") order by filename')
filenames_2 = dbGetQuery(mydb,'select distinct(filename) from world.gencore where filename not in (select filename FROM world.gencore where filename like "/%/%/%/%/%/%") order by filename')

l = k[,"filename"]
li = filenames[,"filename"]
li_2 = filenames_2[,"filename"]
fluidPage(    
  
  # Give the page a title
  titlePanel("Space usage by Directory"),
  
  # Generate a row with a sidebar
  sidebarLayout
  (      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("region", "Directory:", 
                  choices=li),
      selectInput("region2", "Directory:", 
                  choices=li_2),
      hr(),
      helpText("Data from different directories")
    ),
    
    # Create a spot for the barplot
    mainPanel(
                plotOutput("phonePlot"),
                tableOutput("view"),
                plotOutput("line"),
                tableOutput("view2")
              )
    
  )
)