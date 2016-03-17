
plot4 <- function()
{
        ##
        ## Common section for all plots - read in and format hpc data frame.
        ##
        
        # Read headers
        header <- read.table("household_power_consumption.txt", nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
        # Read table, but only the data for 1/2/2007 - 2/2/2007
        hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", skip = 66636, nrows = 2880)
        # Set the headers on the data frame
        colnames(hpc) <- unlist(header)
        # Create new date/time column "datetime" that is constructed out of the Date + Time columns
        hpc$datetime <- strptime(paste(hpc$Date, hpc$Time), format="%d/%m/%Y %H:%M:%S")
        
        ##
        ## Create plot
        ##
        
        # Create output PNG file
        png(filename = "plot4.png")
        
        # Set the number of plots "per page" to 4 going across/horizontally, i.e. fill row 1 first, then row 2.
        par("mfrow" = c(2,2))
        
        # Create/Write plot
        with(hpc, plot(datetime, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power"))
        with(hpc, lines(datetime, Global_active_power))
        
        # Create/Write plot
        with(hpc, plot(datetime, Voltage, type = "n", xlab = "datetime", ylab = "Voltage"))
        with(hpc, lines(datetime, Voltage))
        
        # Create/Write plot
        with(hpc, plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
        with(hpc, lines(datetime, Sub_metering_1, col = "black"))
        with(hpc, lines(datetime, Sub_metering_2, col = "red"))
        with(hpc, lines(datetime, Sub_metering_3, col = "blue"))
        legend("topright", pch = c(" "," "," "),  lty = c("solid", "solid", "solid"), col=c("black", "red","blue"), 
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
        
        # Create/Write plot
        with(hpc, plot(datetime, Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power"))
        with(hpc, lines(datetime, Global_reactive_power))

        # Close the device
        dev.off()
        
        ## Return the data frame as the output for this function
        hpc
}