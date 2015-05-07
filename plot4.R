
## Note that the data starts at 2006-12-16 17:24:00 and increments one minute per row
## there are 60 seconds per minute. The analysis is to cover only two dates, 2/1/2007 and 2/2/2007
## there are 1440 minutes in day, 2880 minutes in two days
## to save time reading the data, this program only reads in the data that is needed
bdate <- strptime("16/12/2006 17:24:00", "%d/%m/%Y %T")
dstart <- strptime("1/02/2007 00:00:00", "%d/%m/%Y %T")
skipcount <- as.integer((as.numeric(dstart)-as.numeric(bdate))/60)
readrows <- 2*1440
file <- "household_power_consumption.txt"
## get data set, seperate character is a semicolon, use the first row as the column names, treat '?' as NA
## only get the'readrows'+'skipcount number of rows, as they contain up through the rows that are to be assessed
dat <- read.table(file, sep = ";", header = TRUE, nrows = (skipcount + readrows), na.strings = "?")
## subset the data to only get the date for the dates that are to be assessed
subdat <- dat[(skipcount+1):(skipcount+readrows),]
## convert the Date and Time columns from a factor to POSITlt and store it back in the Time column
subdat$Time <- strptime(paste(subdat$Date, subdat$Time),"%d/%m/%Y %T")
## fix the Time column to show that it now has the Date and Time
colnames(subdat)[1] <- "Date_Time"
## note - leave the Date column as is
## 4
png("plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))
## 4.1
plot(subdat[,2], subdat$Global_active_power, ylab = "Global Active Power", xlab ="", type="l")
## 4.2
plot(subdat[,2], subdat$Sub_metering_1, ylab = "Energy sub metering", xlab ="", type="l")
lines(subdat[,2], subdat$Sub_metering_2, col = 2)
lines(subdat[,2], subdat$Sub_metering_3, col = 4)
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
## 4.3
plot(subdat[,2], subdat$Voltage, ylab = "Voltage", xlab ="datetime", type="l")
## 4.4
plot(subdat[,2], subdat$Global_reactive_power, ylab = "Global_reactive_power", xlab ="datetime", type="l")
dev.off()