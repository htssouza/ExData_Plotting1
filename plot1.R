############################################################################
# Coursera Programming Assignment
# Johns Hopkins University (Data Science Specialization)
# Exploratory Data Analysis
############################################################################

############################################################################
# Goals for this script
#
# 1-) Download and Extract File.
# 2-) Load File (raw data).
# 3-) Preprocess data.
# 4-) Generate graph on file.

############################################################################
# Debugging constants
SKIP_DOWNLOAD_PROCESS <- FALSE

############################################################################
# Constants (change may be required for your own environment)

SOURCE_FILE_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
RESULT_FILE_PATH <- "plot1.png"

############################################################################
# 1-) Download and Extract File.

if (! SKIP_DOWNLOAD_PROCESS) {
  if(!file.exists("temp")) {
    dir.create("temp")
  }
  temp_file_path <- "temp/raw.zip"
  download.file(url = SOURCE_FILE_URL, destfile = temp_file_path, method = "curl")
  unzip(temp_file_path, exdir = "temp")
}

############################################################################
# 2-) Load File (raw data).

raw_data <- read.csv(
  file = "temp/household_power_consumption.txt",
  sep = ";",
  na.strings = "?"  
)

############################################################################
# 3-) Preprocess data.

data <- raw_data
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- data[data$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")),]

############################################################################
# 4-) Generate graph on file.

png(file = RESULT_FILE_PATH, width = 480, height = 480)
par(mar=c(5,4,2,2))
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", breaks = 12, main = NULL, col="red")
title("Global Active Power")
dev.off()

