## Set the libraries
library(data.table)

# Get and Extract the Data
URL <- "http://d396qusza40orc.cloudfront.net/"
PATH <- "exdata%2Fdata%2F"
FILE <- "household_power_consumption.zip"
if (!file.exists(FILE)){
        message("Downloading data")
        download.file(paste(URL,PATH,FILE,sep=""),FILE)
        unzip(FILE)
}

dtime <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"),units="mins")
rowsToRead <- as.numeric(dtime)
DT <- fread("household_power_consumption.txt", 
            skip="1/2/2007", nrows = rowsToRead, na.strings = c("?", ""))
setnames(DT, colnames(fread("household_power_consumption.txt", nrows=0)))

# add DateTime column

DT$DateTime <- as.POSIXct(paste(DT$Date,DT$Time), format="%d/%m/%Y %H:%M:%S")

# Plot Data and save png file

png(file ="plot4.png")
par(mfcol =c(2,2))
plot(x=DT$DateTime, y=DT$Global_active_power, type = "l", xlab ="",
     ylab = "Global Active Power")
plot(range(DT$DateTime), range(c(DT$Sub_metering_1,
                                 DT$Sub_metering_2, DT$Sub_metering_3)), type='n',
     xlab = "", ylab ="Energy sub metering")
lines(DT$DateTime, DT$Sub_metering_1, type='l') 
lines(DT$DateTime, DT$Sub_metering_2, type='l', col='red')
lines(DT$DateTime, DT$Sub_metering_3, type='l', col='blue')
legend("topright", lty = 1 , col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex =0.95, bty ='n')
plot(DT$DateTime, y=DT$Voltage, type ="l", xlab="datetime", ylab ="Voltage")
plot(DT$DateTime, y=DT$Global_reactive_power, type = "l", xlab = "datetime",
     ylab = "Global_reative_power")
dev.off()
