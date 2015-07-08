library(dplyr)


### Download and read data ###


if (!file.exists("household_power_consumption.txt")){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url,"temp.zip",method="curl")
        unzip("temp.zip")
        unlink("temp.zip")
}


powerdata <- read.table("household_power_consumption.txt",sep=";",
                        na.strings = '?',header = TRUE)

startDate <- as.POSIXct(as.Date("2007-02-01"))
endDate <- as.POSIXct(as.Date("2007-02-03"))


powerdata <- powerdata %>%
                mutate(Time = as.POSIXct(
                        strptime(paste(Date, Time),'%d/%m/%Y %H:%M:%S'))) %>%
                filter(startDate <= Time & Time < endDate)



### Create histogram of Global Active Power ###

png("plot1.png")
with(powerdata,hist(Global_active_power,col="red",main="Global Active Power",
                    xlab="Global Active Power (kilowatts)"))
dev.off()