# This file is to load all the libraries and initalize variables used in other programs

library(data.table)
library(shiny)
library(DBI)
library(RSQLite)

database_name = paste(toString(getwd()),'/world.db',sep="")
mydb <- dbConnect(SQLite(), database_name)
