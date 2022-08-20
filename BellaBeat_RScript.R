# Load library and files 
library(tidyverse)

activity <-read_csv("dailyActivity_merged.csv")
sleep <-read_csv("sleepDay_merged.csv")
weight <-read_csv("weightLogInfo_merged.csv")

# Check that the data has loaded correctly 
head(activity)
head(sleep)

# Convert Id to character data type 
# Convert Day to date format 
# Rename various dates to Day

activity <-activity %>%
  mutate_at(vars(Id), as.character) %>%
  mutate_at(vars(ActivityDate), as.Date, format = "%m/%d/%y") %>%
  rename("Day"="ActivityDate") 
  

sleep <-sleep %>%
  mutate_at(vars(Id), as.character) %>%
  mutate_at(vars(SleepDay), as.Date, format = "%m/%d/%y") %>%
  rename("Day"="SleepDay")

weight <-weight %>%
  mutate_at(vars(Id,LogId), as.character) %>%
  mutate_at(vars(Date),as.Date, format = "%m/%d/%y") %>%
  rename("Day"="Date")


# Combine activity and sleep data frames
combined_data <-sleep %>%
  right_join(activity, by=c("Id","Day")) %>%
  left_join(weight, by=c("Id", "Day"))

# Find and remove duplicate rows; NAs; distinct Ids
combined_data <-combined_data[!duplicated(combined_data), ]

sum(is.na(combined_data))

n_distinct(combined_data$Id)

# Summary Statistics 
summary(combined_data)





