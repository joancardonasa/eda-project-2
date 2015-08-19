## Exploratory Data Analysis: Course Project 2

## @Joan Cardona Sanchez, 2015, Plot 3, using ggplot2 package

## Imports the libraries

library(dplyr)
library(ggplot2)

## Reads the data and transformits it into a tbl object

NEI <- readRDS("summarySCC_PM25.rds")
NEI <- tbl_df(NEI)

## Subsets the data. The year and type columns are converted into factors

NEI <- select(NEI, year, fips, Emissions, type)
NEI <- filter(NEI, fips == "24510") #for Baltimore City

NEI$year <- as.factor(NEI$year) #the 4 levels are "1999" "2002" "2005" "2008"
NEI$type <- as.factor(NEI$type) #the 4 levels are "NON-ROAD" "NONPOINT" "ON-ROAD"  "POINT"

NEI <- NEI %>%                                ##This piece of code groups
    group_by(year, type) %>%                  ##The data frame into year and type
    summarise(tot_emissions = sum(Emissions)) ##So we get a 16 row table (each total)

png(file = "plot3.png", width = 480, height = 480)

x <- qplot(year, tot_emissions, data = NEI, color = type) + 
    labs(title = "Total Emissions for each type", x = "Year", y = "Total Emissions in Baltimore City") + 
    geom_point(size = 4.25) 
print(x) ## It seems that if I don't add this temporary variable x and print it, the png 
         ## device will sometimes fail
dev.off()