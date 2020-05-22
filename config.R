<<<<<<< HEAD
# This file is to load all the libraries and initalize variables used in other programs

setwd('C:/ShinyApp')

library(data.table)
library(RMySQL)
library(shiny)
library(DBI)
library(RSQLite)

database_name = paste(toString(getwd()),'/world.db',sep="")
=======
# This file is to load all the libraries and initalize variables used in other programs

setwd('C:/ShinyApp')

library(data.table)
library(RMySQL)
library(shiny)
library(DBI)
library(RSQLite)

database_name = paste(toString(getwd()),'/world.db',sep="")
>>>>>>> 3a2a449ba898275cf793b3c8c38f0be7309b9c60
mydb <- dbConnect(SQLite(), database_name)