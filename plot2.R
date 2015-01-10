#R code for Course Peer Project 1 in Exploratory Data Analysis course.
#This code uses “Individual household electric power consumption Data Set” from UC Irvine Machine Learning Repository (http://archive.ics.uci.edu/ml/).

#Plot2.R

#It is assumed that file household_power_consumption.txt is available in the working directory.

#the below code for uploading file is identical as in the plot1.R file

#defining regexp pattern for needed dates
datePattern <- "^(1|2)/2/2007"

#creating a temporary file containing only data matching defined pattern
cat(
  grep(
    datePattern, 
    readLines("household_power_consumption.txt")
    , value=TRUE
  )
  , sep="\n"
  , file="tmp.file"
)

power.consumption.data <- read.csv2(
  file="tmp.file"
  , header=FALSE
  , colClasses=c("character", "character", rep("numeric",7))
  , na.strings="?"
  , col.names=c(
    "Date"
    ,"Time"
    ,"Global_active_power"
    ,"Global_reactive_power"
    ,"Voltage"
    ,"Global_intensity"
    ,"Sub_metering_1"
    ,"Sub_metering_2"
    ,"Sub_metering_3"
  )
  , dec="."
)

#cleaning space
unlink("tmp.file")

#creating new DateTime variable containing Date and Time in more useful format
power.consumption.data$DateTime <- strptime(
  paste(
    power.consumption.data$Date
    , power.consumption.data$Time
  )
  , format="%d/%m/%Y %H:%M:%S"
)

#generating plot2.png for Project 1
png(
  filename="plot2.png"
  , width=480
  , height=480
  , bg="transparent"
)

plot(
  power.consumption.data$DateTime
  , power.consumption.data$Global_active_power
  , main=""
  , ylab="Global Active Power (kilowatts)"
  , xlab=""
  , type="l"
)

dev.off()
