
plot2 <- function()
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
        png(filename = "plot2.png")
		
		# Reset the number of plots "per page".
        par("mfrow" = c(1,1))
		
        # Create/Write plot
        with(hpc, plot(datetime, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowats)"))
        with(hpc, lines(datetime, Global_active_power))
		
        # Close the device
        dev.off()
        
        ## Return the data frame as the output for this function
        hpc
}