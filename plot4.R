#set working directory
setwd("C:\\Users\\N\\Dropbox\\Coursera\\04 - Exploratory Data Analysis\\project1\\ExData_Plotting1")

#Load file, but only the first 100,000 entries to speed things up
dat=read.table("household_power_consumption.txt", sep=";",
               header=TRUE,
               stringsAsFactors=FALSE,
               na.strings="?",
               nrows=100000)
#Change date to Posix by appending the Data and Time and
#converting it to a POSIX type
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
png(file="plot4.png")

#prepare subplot:
par(mfrow=c(2,2))

#Plot 1
plot(dat$Date,dat$Global_active_power,
     type="n",
     xlab="",
     ylab="Global Active Power (kilowatts)")
#draw lines
lines(dat$Date,dat$Global_active_power)

#Plot 2
plot(dat$Date,dat$Voltage,
     type="n",
     xlab="datetime",
     ylab="Voltage")
#draw lines
lines(dat$Date,dat$Voltage)


#Plot 3
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

legend("topright", col=c("black","red","blue"), 
       lty = c(1, 1,1), #add line entries
       bty = "n", #remove outline from box
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Plot 4
plot(dat$Date,dat$Global_reactive_power,
     type="n",
     xlab="datetime",
     ylab="Global_reactive_power")
#draw lines
lines(dat$Date,dat$Global_reactive_power)



#release file:
dev.off()
