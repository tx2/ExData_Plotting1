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

# Create and save Global Active Power scatterplot
png(file="plot2.png")
plot(data[,3], type="l", ylab="Global Active Power (kilowatts)", xlab="", axes=F)
axis(1, at=1440*0:2, lab=c("Thu","Fri","Sat"))
axis(2, at=2*0:3)
box()
dev.off();