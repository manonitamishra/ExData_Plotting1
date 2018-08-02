#Read the data file
v_colClass <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
df_power <- read.table("household_power_consumption.txt",header = TRUE, sep = ";", colClasses = v_colClass, na.strings = "?")

#Subset the required data
df_power_date <- subset(df_power, (Date == "1/2/2007" | Date == "2/2/2007"))

#Convert the date and time columns to required data types.
df_power_date$Time <- as.POSIXlt(df_power_date$Time, format = "%H:%M:%S", tz=Sys.timezone())
df_power_date$Date <- as.Date(df_power_date$Date, "%d/%m/%Y", tz=Sys.timezone())

#Plot the graph
par(mfrow = c(1,1))

hist(df_power_date$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#output to a PNG file
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()
