## Exploratory Data Analysis: Course Project 2

## @Joan Cardona Sanchez, 2015, Plot 4

## Imports the libraries

library(dplyr)
library(ggplot2)

## Reads the data and transformits it into a tbl object

NEI <- readRDS("summarySCC_PM25.rds")
NEI <- tbl_df(NEI)

SCC <- readRDS("Source_Classification_Code.rds")
SCC <- tbl_df(SCC)

## In order to fins Coal Combusted related sources, I'm gonna be using the following info:
## http://www.epa.gov/air/emissions/basic.htm
## In this webpage we can see that the coal combustion related sources are:

##    "Fuel Comb - Comm/Institutional - Coal"  
##    "Fuel Comb - Electric Generation - Coal" 
##    "Fuel Comb - Industrial Boilers, ICEs - Coal" 

## We can find these sources in SCC$EI.Sector in the form of levels, with the corresponding
## levels: 13, 18, and 23. But we don't know this, so we're just gonna subset to
## the sources which contain the world "coal":

## ...





png(file = "plot4.png", width = 480, height = 480)

## ... 

dev.off()