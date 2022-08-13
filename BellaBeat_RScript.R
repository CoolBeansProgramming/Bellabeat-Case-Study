# Load library 
library(tidyverse)

# Load CSV files 
activity <-read_csv("dailyActivity_merged.csv")
sleep <-read_csv("sleepDay_merged.csv")

# Check that the data has loaded correctly 
head(activity)
head(sleep)

# Convert Id to character data type 
# Rename ActivityDate, SleepDay to Day
activity <-activity %>%
  mutate_at(vars(Id), as.character) %>%
  rename("Day"="ActivityDate")

sleep <-sleep %>%
  mutate_at(vars(Id), as.character) %>%
  rename("Day"="SleepDay")

# Combine the data
combined_data <-sleep %>%
  right_join(activity, by=c("Id","Day"))
summary(combined_data)





