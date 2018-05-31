# Script that plots histogram of global active power (kilowatts)
# Assumes household_power_consumption.txt is stored in working directory

library(data.table)

# Read data and subset to 2007-02-01 and 2007-02-02
hpc <- fread('household_power_consumption.txt', 
             na.strings = c("NA", "?"))
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
hpc <- hpc[Date == '2007-02-01' | Date == '2007-02-02']

# Open PNG device
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# Generate histogram
hist(hpc$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     col = "red")

# Close PNG device
dev.off()



