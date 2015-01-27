library(data.table)
library(ggplot2)
library(reshape2)

## This first line will likely take a few seconds. Be patient!
NEI <- data.table(readRDS("data/summarySCC_PM25.rds"))
SCC <- data.table(readRDS("data/Source_Classification_Code.rds"))

##Take just the data related to Baltimore and LA
balt = NEI[fips == "24510", ]
LA = NEI[fips == "06037", ]

##Merge the datasets from balt and LA with the SCC
balt.SCC = merge(balt, SCC, by="SCC")
LA.SCC = merge(LA, SCC, by="SCC")

##Subset the observations related to vehicles
balt.PM.vehicles = balt.SCC[grep("Vehicles", balt.SCC$EI.Sector), ]
LA.PM.vehicles = LA.SCC[grep("Vehicles", LA.SCC$EI.Sector), ]

##Merge the datasets of the sum of the emissions from LA and Baltimore and melt them so that it has three columns:
##Year, emissions and state
PM.vehicles.year = merge(balt.PM.vehicles[, list(emissions.Baltimore=sum(Emissions)), by="year"],
                         LA.PM.vehicles[, list(emissions.LA=sum(Emissions)), by="year"],
                         by="year")
PM.vehicles.year = melt(PM.vehicles.year, id="year")
names(PM.vehicles.year) = c("year", "state", "emissions")
PM.vehicles.year$state = sub("emissions.", "", PM.vehicles.year$state)
       
ggplot(PM.vehicles.year, aes(x=year, y=emissions)) + geom_line() + facet_wrap(~state, scales="free")

dev.copy(png, "plot6.png")
dev.off()

