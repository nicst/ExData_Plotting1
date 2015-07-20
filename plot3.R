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

startTime <- as.POSIXct(
        strptime("2007-02-01 00:00:00",'%Y-%m-%d %H:%M:%S'))
endTime <- as.POSIXct(
        strptime("2007-02-02 23:59:59",'%Y-%m-%d %H:%M:%S'))


powerdata <- powerdata %>%
        mutate(Time = as.POSIXct(
                strptime(paste(Date, Time),'%d/%m/%Y %H:%M:%S'))) %>%
        filter(startTime <= Time & Time <= endTime)



### Plot different Energy sub meterings over time ###

png("plot3.png")
with(powerdata,{
        plot(Time,Sub_metering_1,type="l",ylab="Energy sub metering");
        lines(Time,Sub_metering_2,col="red");
        lines(Time,Sub_metering_3,col="blue");
        legend("topright",
               legend=c("sub_metering 1","sub_metering 2","sub_metering 3"),
               lty=c(1,1),col=c("black","red","blue"));
        
})
dev.off()

