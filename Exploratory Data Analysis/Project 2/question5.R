# Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Generate tidy data for performance, for Baltimore City
tidyData5 = NEI[NEI$fips == "24510",]

tidyData5 <- merge(tidyData5,SCC,by = "SCC")

# According with wikipedia definition of motor vehicle :
# "is a self-propelled wheeled vehicle that does not operate on rails"
# http://en.wikipedia.org/wiki/Motor_vehicle
tidyData5 <- tidyData5[grep("Vehicle+", tidyData5$Short.Name),]

tidyData5 <-aggregate(tidyData5$Emissions, by=list(year = tidyData5$year), FUN=sum)

colnames(tidyData5)[2] = "Emissions"

# Open PNG file
png(filename = "plot5.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")

# Generate plot
plot(tidyData5$year, tidyData5$Emissions,type ="l", col ="blue", xlab = "Years", ylab = "Emissions(Tons)")
title(main = "Emissions from motor vehicle sources in Baltimore City")

# off PNG device
dev.off()