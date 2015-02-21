# Install package ggplot2
install.packages("ggplot2")
library(ggplot2) 

# Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Generate tidy data for performance
tidyData2 <-aggregate(NEI$Emissions, by=list(NEI$type, NEI$year), FUN=sum)
colnames(tidyData2)[1] = "Type"
colnames(tidyData2)[2] = "Year"
colnames(tidyData2)[3] = "Emissions"

# Open PNG file
png(filename = "plot3.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")

# Generate plot
g = qplot(Year, Emissions, data=tidyData2, facets = Type ~ ., color=Type, geom = c("line"), title = "Emissions for Baltimore City by type")
g + ggtitle("Total Emissions in Baltimore City from 1999 to 2008")

# off PNG device
dev.off()