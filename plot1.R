library(data.table)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- data.table(readRDS("data/summarySCC_PM25.rds"))

##Create a data.table which contains the total of emissions from all sources by year
PM = NEI[, list(emissions=sum(Emissions)), by="year"] 

with(PM, plot(year, emissions, "l", main="Total emissions in US")) 

##Emissions do have decreased

dev.copy(png, "plot1.png")
dev.off()