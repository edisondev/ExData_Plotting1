#set working directory
setwd("C:\\Users\\N\\Dropbox\\Coursera\\04 - Exploratory Data Analysis\\project1\\ExData_Plotting1")

#Load file, but only the first 100,000 entries to speed things up
dat=read.table("household_power_consumption.txt", sep=";",
               header=TRUE,
               stringsAsFactors=FALSE,
               na.strings="?",
               nrows=100000)
#Change date to Posix
tmp=strptime(paste(dat$Date, dat$Time, sep=" "),
             format="%d/%m/%Y %H:%M:%S")

#reassign the date to the data frame
dat["Date"]<-as.POSIXct(tmp)

#find entries
startdate=as.POSIXct("02/01/2007", format = "%m/%d/%Y")
enddate=as.POSIXct("02/03/2007", format = "%m/%d/%Y")

#find rows equal to the start and end date
index=(dat$Date<enddate & dat$Date>=startdate)
#get final data with the two day entries
dat=dat[index,]


#Plotting and Saving Code- Plot 3
#open file
png(file="plot3.png")
#prepare plot:
plot(dat$Date,dat$Sub_metering_1,
     type="n",
     xlab="",
     ylab="Energy sub metering"
     )
#draw lines
lines(dat$Date,dat$Sub_metering_1
      , col="black")
lines(dat$Date,dat$Sub_metering_2
      , col="red")
lines(dat$Date,dat$Sub_metering_3
      , col="blue")

legend("topright", col=c("black","red","blue"), lty = c(1, 1,1),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#release file:
dev.off()
