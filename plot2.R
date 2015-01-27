library(data.table)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- data.table(readRDS("data/summarySCC_PM25.rds"))

##Take just the data related to Baltimore
balt = NEI[fips==24510, ]
balt= balt[, list(emissions=sum(Emissions)), by="year"] 

with(balt, plot(year, emissions, "l", main="Total emissions in Baltimore")) 

##Emissions do have decreased

dev.copy(png, "plot2.png")
dev.off()