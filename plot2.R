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

png(file ="plot2.png")
plot(x=DT$DateTime, y=DT$Global_active_power, type = "l", xlab ="",
     ylab = "Global Active Power (kilowatts)")
dev.off()

