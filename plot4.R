#how much memory the dataset will require
print(object.size(read.delim("hh_power.txt", sep = ";",stringsAsFactors = FALSE)),units="Mb")
#its okay to load the whole file & take a subset after
power <- read.delim("hh_power.txt", sep = ";",stringsAsFactors = FALSE)
#subset data
powerss <- power[power$Date=="1/2/2007" | power$Date=="2/2/2007",]
#formatting the date-variable
d <- paste0(0, substr(powerss$Date,1,1))
m <- paste0(0, substr(powerss$Date,3,3))
y <- substr(powerss$Date,5,8)
powerss$Date <- strptime(paste0(d,"/",m,"/",y),"%d/%m/%Y")
powerss$Date <- as.Date(powerss$Date,"%Y-%m-%d")
#powerss$Time <- strptime(powerss$Time, "%T")
powerss$Global_active_power <- as.numeric(powerss$Global_active_power)
powerss$Global_reactive_power <- as.numeric(powerss$Global_reactive_power)
powerss$Voltage <- as.numeric(powerss$Voltage)
powerss$Global_intensity <- as.numeric(powerss$Global_intensity)
powerss$Sub_metering_1 <- as.numeric(powerss$Sub_metering_1)
powerss$Sub_metering_2 <- as.numeric(powerss$Sub_metering_2)
powerss$Sub_metering_3 <- as.numeric(powerss$Sub_metering_3)

#Plot 4
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
par(mfrow=c(2,2))
#1
plot(powerss$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
axis(1, at=c(0,middle,right),labels=c("Thu","Fri","Sat"), las=0)
#2
plot(powerss$Voltage, type="l", ylab="Voltage", xlab="datetime", xaxt="n")
axis(1, at=c(0,middle,right),labels=c("Thu","Fri","Sat"), las=0)
#3
plot(powerss$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", xaxt="n")
axis(1, at=c(0,middle,right),labels=c("Thu","Fri","Sat"), las=0)
lines(powerss$Sub_metering_2, col="red")
lines(powerss$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.5, lty=c(1,1,1), col=c("black","red", "blue"))
#4
plot(powerss$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime", xaxt="n")
axis(1, at=c(0,middle,right),labels=c("Thu","Fri","Sat"), las=0)
par(mfrow=c(1,1))
dev.off()