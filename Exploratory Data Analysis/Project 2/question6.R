# Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Generate tidy data for performance, for Baltimore City
baltimoreData = NEI[NEI$fips == "24510",]
baltimoreData <- merge(baltimoreData,SCC,by = "SCC")

LAData = NEI[NEI$fips == "06037",]
LAData <- merge(LAData,SCC,by = "SCC")


# According with wikipedia definition of motor vehicle :
# "is a self-propelled wheeled vehicle that does not operate on rails"
# http://en.wikipedia.org/wiki/Motor_vehicle
baltimoreData <- baltimoreData[grep("Vehicle+", baltimoreData$Short.Name),]
baltimoreData <-aggregate(baltimoreData$Emissions, by=list(year = baltimoreData$year, city =  baltimoreData$fips), FUN=sum)
colnames(baltimoreData)[3] = "Emissions"

LAData <- LAData[grep("Vehicle+", LAData$Short.Name),]
LAData <-aggregate(LAData$Emissions, by=list(year = LAData$year, city =  LAData$fips), FUN=sum)
colnames(LAData)[3] = "Emissions"

# Open PNG file
png(filename = "plot6.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")

# Generate plot
plot(baltimoreData$year, baltimoreData$Emissions,type ="l", col ="blue", xlab = "Years", ylab = "Emissions(Tons)")
par(new=TRUE)
plot(LAData$year, LAData$Emissions,type ="l", col ="red",xlab = "", ylab = "", xaxt="n", yaxt="n")
legend("topright", legend = c("Baltimore","Los Angeles"), col=1:2, pch=1) # optional legend
title(main = "Emissions from motor vehicle sources")
# off PNG device
dev.off()
