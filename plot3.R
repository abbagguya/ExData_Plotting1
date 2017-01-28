# Exploratory Data Analysis Week 1 Project
# plot3.R
# James Kim
# 1-27-2017

# household_power_consumption data delimited by ";"
# 2,075,259 x 9 x 8 = 146 MB needed to load the entire data set
# my laptop can handle 146 MB of memory without a problem

# working directory is set to the local repo
electric.power.consumption <-read.table("household_power_consumption.txt",
                                        sep = ";",
                                        header = TRUE,
                                        stringsAsFactors = FALSE)

dim(electric.power.consumption) # 2,075,259 x 9 OK
str(electric.power.consumption) # OK

require(dplyr)
# isolate data of interest
consumption.feb.1to2.2017 <-
    electric.power.consumption %>%
    tbl_df() %>%
    filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
    mutate(Date.Time = ymd_hms(paste(dmy(Date), Time))) %>%
    mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
    mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
    mutate(Sub_metering_3 = as.numeric(Sub_metering_3))

dim(consumption.feb.1to2.2017) # 1440 rows for feb. 1 1440 rows for feb. 2
str(consumption.feb.1to2.2017)

# first out to quartz() to examine
with(consumption.feb.1to2.2017, plot(Date.Time,
                                     Sub_metering_1,
                                     type = 'l',
                                     xlab = "",
                                     ylab ="Energy sub metering"))
with(consumption.feb.1to2.2017, lines(Date.Time,
                                      Sub_metering_2,
                                      col = 'red'))
with(consumption.feb.1to2.2017, lines(Date.Time,
                                      Sub_metering_3,
                                      col = 'blue'))
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c('black', 'red', 'blue'),
       lty = 1)

# output to PNG
png("plot3.png")
with(consumption.feb.1to2.2017, plot(Date.Time,
                                     Sub_metering_1,
                                     type = 'l',
                                     xlab = "",
                                     ylab ="Energy sub metering"))
with(consumption.feb.1to2.2017, lines(Date.Time,
                                      Sub_metering_2,
                                      col = 'red'))
with(consumption.feb.1to2.2017, lines(Date.Time,
                                      Sub_metering_3,
                                      col = 'blue'))
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c('black', 'red', 'blue'),
       lty = 1)
dev.off()

