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

#Plot 2
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
plot(powerss$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
middle <- length(powerss$Global_active_power)/2
right <- length(powerss$Global_active_power)
axis(1, at=c(0,middle,right),labels=c("Thu","Fri","Sat"), las=0)
dev.off()
