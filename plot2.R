# Script that plots Global Active Power (kilowatts) over span of Thu--Sat
# Assumes household_power_consumption.txt is stored in working directory

library(data.table)

# Read data and subset to 2007-02-01 and 2007-02-02
hpc <- fread('household_power_consumption.txt', 
             na.strings = c("NA", "?"))
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
hpc <- hpc[Date == '2007-02-01' | Date == '2007-02-02']
hpc <- hpc[, Time := strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S")]

# Open PNG device
png(filename = "plot2.png", width = 480, height = 480, units = "px")

# Generate scatterplot joined by line
plot(hpc$Time, hpc$Global_active_power,
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     type = "l")

# Close PNG device
dev.off()



