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

# Create and save scatterplots
png(file="plot4.png")
par(mfcol=c(2, 2))

# Global Active Power
plot(data[,3], type="l", ylab="Global Active Power (kilowatts)", xlab="", axes=F)
axis(1, at=1440*0:2, lab=c("Thu","Fri","Sat"))
axis(2, at=2*0:3)
box()

# Energy sub metering
plot(data[,7], type="l", ylab="Energy sub metering", xlab="", axes=F)
points(data[,8], type="l", col="red")
points(data[,9], type="l", col="blue")
axis(1, at=1440*0:2, lab=c("Thu","Fri","Sat"))
axis(2, at=10*0:3)
box()
legend("topright", pch="_", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n")

# Voltage
plot(data[,5], type="l", ylab="Voltage", xlab="datetime", axes=F)
axis(1, at=1440*0:2, lab=c("Thu","Fri","Sat"))
axis(2, at=234+2*0:6, lab=c(234,"",238,"",242,"",246))
box()

# Global_reactive_power
plot(data[,4], type="l", ylab="Global_reactive_power", xlab="datetime", axes=F)
axis(1, at=1440*0:2, lab=c("Thu","Fri","Sat"))
axis(2, at=0.1*0:5)
box()

dev.off();