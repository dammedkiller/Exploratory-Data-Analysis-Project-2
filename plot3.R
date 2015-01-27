library(data.table)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- data.table(readRDS("data/summarySCC_PM25.rds"))

##Take just the data related to Baltimore
balt = NEI[fips==24510, ]

PM.type.year = balt[, list(emissions=sum(Emissions)), by=c("type", "year")]

ggplot(PM.type.year, aes(x=year, y=emissions)) + geom_line() + facet_wrap(~type, scales="free")
##All sources but point have seen decreases in emissions

dev.copy(png, "plot3.png")
dev.off()
