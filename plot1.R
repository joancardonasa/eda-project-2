## This first line will likely take a few seconds. Be patient!
library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
NEI <- tbl_df(NEI)
NEI <- select(NEI, year, Emissions)

NEI$year <- as.factor(NEI$year) #the 4 levels are "1999" "2002" "2005" "2008"
years <- levels(NEI$year)

d1 <- filter(NEI, year == "1999")
d2 <- filter(NEI, year == "2002")
d3 <- filter(NEI, year == "2005")
d4 <- filter(NEI, year == "2008")

e1 <- sum(d1$Emissions, na.rm = T)
e2 <- sum(d2$Emissions, na.rm = T)
e3 <- sum(d3$Emissions, na.rm = T)
e4 <- sum(d4$Emissions, na.rm = T) #I should loop this...

df <- data.frame(as.numeric(years), c(e1, e2, e3, e4))
colnames(df) <- c("Years", "Emissions")

png(file = "plot1.png", width = 480, height = 480)

plot(df$Years, df$Emissions, xlab = "Years", ylab = "Tons of Emissions", xaxt = "n",
     ylim = c(0.9 * e4, 1.05 * e1),
     col = "blue", pch = 19)
axis(1, at = years)
grid(5, 5, lwd = 2) #grid in both directions
abline(lm(df$Emissions ~ df$Years), lwd = 1.5)

dev.off()