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

SCC$EI.Sector <- as.character(SCC$EI.Sector)

# Data subsetting for SCC, just coal combustion related sources

SCC <- filter(SCC, grepl("coal", SCC$EI.Sector, ignore.case = T)) # grepl returns a logical
                                                                  # containing TRUES (99 rows)

## From this moment, SCC only has coal combustion related sources
## This has to be reflected when we subset NEI, the other dataframe

scc_vec <- as.character(SCC$SCC)
scc_vec <- as.numeric(scc_vec) # this vector contains the SCC's of C.C. related sources

# Data subsetting for NEI and group_by of years

NEI$year <- as.factor(NEI$year) # this is done so the graph displays only the detailed years

NEI <- NEI %>% 
    filter(SCC %in% scc_vec) %>% 
    select(year, Emissions) %>%
    group_by(year) %>%
    summarise(tot_emissions = sum(Emissions))

## Activating graphic device: png

png(file = "plot4.png", width = 480, height = 480)

x <- qplot(year, tot_emissions, data = NEI) +
    labs(title = "Total Emissions of Coal Combustion Related Sources", x = "Year", y = "Total Tons of Emissions") +
    geom_point(size = 3.35) 
print(x)

dev.off()

## In this part of the project I have started using pipe operators. 
## As you can see, the code is much more concise and avoids repeating 
## patterns like in the previous exercises.