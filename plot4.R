library(data.table)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- data.table(readRDS("data/summarySCC_PM25.rds"))
SCC <- data.table(readRDS("data/Source_Classification_Code.rds"))

##merge both datasets
NEI.SCC = merge(NEI, SCC, by="SCC")

##Take those SCC values of SCC where Short.Names has "coal" or "Coal" (where SCC is any type of coal)
PM.coal = NEI.SCC[grep("[Cc]oal", NEI.SCC$EI.Sector), ]

PM.coal.year= PM.coal[, list(emissions = sum(Emissions)), by="year"]

with(PM.coal.year, plot(year, emissions, "l", main="Coal related emissions"))

dev.copy(png, "plot4.png")
dev.off()
