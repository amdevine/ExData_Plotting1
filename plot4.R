# Script that plots four different plots (Global Active Power, Voltage,
# Energy sub metering, and Global_reactive_power) over a Thu - Sat range.
# Assumes household_power_consumption.txt is stored in working directory

library(data.table)

# Read data and subset to 2007-02-01 and 2007-02-02
hpc <- fread('household_power_consumption.txt', 
             na.strings = c("NA", "?"))
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
hpc <- hpc[Date == '2007-02-01' | Date == '2007-02-02']
hpc <- hpc[, datetime := strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S")]

# Open PNG device
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# Set global parameters to accept 2x2 panels, filled row-wise
par(mfrow = c(2, 2))

# Generate Global Active Power line graph and Voltage line graph
with(hpc, {
    plot(datetime, Global_active_power, 
         xlab = "", ylab = "Global Active Power", type = "l")
    plot(datetime, Voltage, type = "l")
})

# Generate Energy sub metering graph
max_submeter <- with(hpc, pmax(Sub_metering_1, Sub_metering_2, Sub_metering_3))
plot(hpc$datetime, max_submeter, xlab = "", ylab = "Energy sub metering",
     type = "n")
points(hpc$datetime, hpc$Sub_metering_1, col = "black", type = "l")
points(hpc$datetime, hpc$Sub_metering_2, col = "red", type = "l")
points(hpc$datetime, hpc$Sub_metering_3, col = "blue", type = "l")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n")

# Generate Global_reactive_power graph
with(hpc, plot(datetime, Global_reactive_power, type = "l"))

# Close PNG device
dev.off()



