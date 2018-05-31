# Script that plots three different sub-metering series over span of Thu--Sat
# Assumes household_power_consumption.txt is stored in working directory

library(data.table)

# Read data and subset to 2007-02-01 and 2007-02-02
hpc <- fread('household_power_consumption.txt', 
             na.strings = c("NA", "?"))
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
hpc <- hpc[Date == '2007-02-01' | Date == '2007-02-02']
hpc <- hpc[, Time := strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S")]

# Open PNG device
png(filename = "plot3.png", width = 480, height = 480, units = "px")

# Generate empty scatterplot with axes
max_submeter <- with(hpc, pmax(Sub_metering_1, Sub_metering_2, Sub_metering_3))
plot(hpc$Time, 
     max_submeter,
     xlab = "",
     ylab = "Energy sub metering",
     type = "n")

# Add individual series as points
points(hpc$Time, hpc$Sub_metering_1,
       col = "black",
       type = "l")
points(hpc$Time, hpc$Sub_metering_2,
       col = "red",
       type = "l")
points(hpc$Time, hpc$Sub_metering_3,
       col = "blue",
       type = "l")

# Add legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), 
       lty = 1)

# Close PNG device
dev.off()



