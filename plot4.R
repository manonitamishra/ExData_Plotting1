#Read the data file
v_colClass <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
df_power <- read.table("household_power_consumption.txt",header = TRUE, sep = ";", colClasses = v_colClass, na.strings = "?")

#Subset the required data
df_power_date <- subset(df_power, (Date == "1/2/2007" | Date == "2/2/2007"))

#Convert the date and time columns to required data types.
df_power_date$DateTime <- paste(df_power_date$Date, df_power_date$Time)
df_power_date$DateTime <- as.POSIXct(df_power_date$DateTime,format="%d/%m/%Y %H:%M:%S",tz=Sys.timezone())


df_power_date$Time <- as.POSIXlt(df_power_date$Time, format = "%H:%M:%S", tz=Sys.timezone())
df_power_date$Date <- as.Date(df_power_date$Date, "%d/%m/%Y", tz=Sys.timezone())

#Plot the graph
par(mfrow = c(2,2), mar=c(4,4,2,2))


#Graph1
with(df_power_date, plot(Global_active_power ~ DateTime, xlab = "", ylab="Global Active Power", type="l", ylim = c(0,6)))

#Graph2
with(df_power_date, plot(Voltage ~ DateTime, type="l"))

#Graph3
with(df_power_date, plot(Sub_metering_1 ~ DateTime, type="l", col = "Black", ylab="Energy sub metering", xlab = ""))
points(df_power_date$DateTime, df_power_date$Sub_metering_2, col = "Red", type =  "l")
points(df_power_date$DateTime, df_power_date$Sub_metering_3, col = "Blue", type =  "l")
legend("topright", pch = "___", bty = "n", col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Graph4
with(df_power_date, plot(Global_reactive_power ~ DateTime, type="l"))


#output to a PNG file
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()



