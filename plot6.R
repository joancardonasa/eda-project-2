## Exploratory Data Analysis: Course Project 2

## @Joan Cardona Sanchez, 2015, Plot 6

## Imports the libraries

library(dplyr)
library(ggplot2)

## Reads the data and transformits it into a tbl object

NEI <- readRDS("summarySCC_PM25.rds")
NEI <- tbl_df(NEI)

SCC <- readRDS("Source_Classification_Code.rds")
SCC <- tbl_df(SCC)

## In order to find the Motor Vehicle sources, I'm gonna be using the following info:
## http://www.epa.gov/air/emissions/basic.htm
## In this webpage we can see that the motor vehicle related sources are:

## On-Road Diesel/Gasoline Heavy/Light Duty Vehicles (US definition of motor vehicles)

## Therefore, we only have to search for "vehicle" in the EI.Sector of the SCC table:

SCC$EI.Sector <- as.character(SCC$EI.Sector)
SCC <- filter(SCC, grepl("vehicle", SCC$EI.Sector, ignore.case = T))

SCC$SCC <- as.character(SCC$SCC)
scc_vec <- SCC$SCC # This vector contains the scc's of motor vehicle sources

# Data subsetting for NEI and group_by of years

NEI$year <- as.factor(NEI$year) # this is done so the graph displays only the detailed years

NEI <- NEI %>% 
    filter(SCC %in% scc_vec, fips == "24510" | fips == "06037") %>% # fips specified for Baltimore and LA 
    select(year, Emissions, fips) %>%
    group_by(year, fips) %>%
    summarise(tot_emissions = sum(Emissions))

## Activating graphic device: png

png(file = "plot6.png", width = 480, height = 480)

x <- qplot(year, tot_emissions, data = NEI, color = fips) + 
    labs(title = "Total Emissions for each location, Baltimore (24510) and LA (06037)", x = "Year", y = "Total Emissions") + 
    geom_point(size = 4.25) 
print(x) ## It seems that if I don't add this temporary variable x and print it, the png 
## device will sometimes fail
dev.off()
