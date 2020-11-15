# Read the data.
# Read from file household_power_consumption.txt.
# Only lines that start with 1/2/2007 or 2/2/2007.
library(data.table)
colNames <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
colCls = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
df1 <- fread(cmd = "grep -E '^1/2/2007|^2/2/2007' household_power_consumption.txt", sep = ";", na.strings="?", col.names = colNames, colClasses = colCls)

# Merge columns Date and Time into one column Datetime
col1 <- paste(df1$Date, df1$Time)
df1 <- cbind(strptime(col1, format = "%d/%m/%Y %H:%M:%S"), df1[,c(3:9)])
names(df1)[1] <- "Datetime"

# Plot the Global Active Power over the two days in a PNG file named plot2.png
png(file = "plot2.png")
plot(df1$Datetime, df1$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off()
