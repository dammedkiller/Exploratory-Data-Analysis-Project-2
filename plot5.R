library(data.table)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- data.table(readRDS("data/summarySCC_PM25.rds"))
SCC <- data.table(readRDS("data/Source_Classification_Code.rds"))

##Take just the data related to Baltimore
balt = NEI[fips==24510, ]

##Merge both datasets
balt.SCC = merge(balt, SCC, by="SCC")

##Subset the observations related to vehicles
PM.vehicles = balt.SCC[grep("Vehicles", balt.SCC$EI.Sector), ]

PM.vehicles.year=PM.vehicles[, list(emissions=sum(Emissions)), by="year"]
PM.vehicles.year = PM.vehicles.year[order(year), ]

with(PM.vehicles.year, plot(year, emissions, "l", main="Emissions in Baltimore related to vehicle sources"))

dev.copy(png, "plot5.png")
dev.off()
