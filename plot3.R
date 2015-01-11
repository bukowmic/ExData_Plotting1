#R code for Course Peer Project 1 in Exploratory Data Analysis course.
#This code uses “Individual household electric power consumption Data Set” 
#from UC Irvine Machine Learning Repository (http://archive.ics.uci.edu/ml/).

#Plot3.R

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

#setting english setlocale
local.time <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")

#generating plot3.png for Project 1
png(
  filename="plot3.png"
  , width=480
  , height=480
  , bg="transparent"
)

with(power.consumption.data, {
  #initializing the empty plot
  plot(
    DateTime
    , Sub_metering_1
    , main=""
    , ylab="Energy sub metering"
    , xlab=""
    , type="n"
  )
  
  #adding lines for Sub metering 1
  lines(
    DateTime
    , Sub_metering_1
    , col="black"
  )
  
  #adding lines for Sub metering 2
  lines(
    DateTime
    , Sub_metering_2
    , col="red"
  )
  
  #adding lines for Sub metering 3
  lines(
    DateTime
    , Sub_metering_3
    , col="blue"
  )
  
  #adding legend
  legend(
    "topright"
    , legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    , col=c("black", "red", "blue")
    , lty=1
  )
})

dev.off()

#setting previous datime settings
Sys.setlocale("LC_TIME", local.time)
