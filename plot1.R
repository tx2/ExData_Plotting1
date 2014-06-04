# Download and read household power consumption data
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), header=T, sep=";", na.strings="?")
unlink(temp)

# Cleaning data
data[,1] <- as.Date(data[,1], format="%d/%m/%Y")
data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]
data[,2] <- format(strptime(data[,2], format="%H:%M:%S"), format="%H:%M:%S")
for(i in 3:8){
        data[,i] <- as.numeric(as.character(data[,i]))        
}

# Create and save as png Global Active Power histogram
png(file="plot1.png")
hist(data[,3], col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off();