# Load library and files 
library(tidyverse)
require(forcats)
library(openxlsx)

activity <-read_csv("dailyActivity_merged.csv")
sleep <-read_csv("sleepDay_merged.csv")
weight <-read_csv("weightLogInfo_merged.csv")

# Check that the data has loaded correctly 
head(activity)
head(sleep)
head(weight)

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


# Combine data frames; add day of the week 
combined_data <-sleep %>%
  right_join(activity, by=c("Id","Day")) %>%
  left_join(weight, by=c("Id", "Day")) %>%
  mutate(Weekday = weekdays(as.Date(Day, "m/%d/%Y")))

# Find and remove duplicate rows; count NAs and distinct Ids
combined_data <-combined_data[!duplicated(combined_data), ]
sum(is.na(combined_data))
n_distinct(combined_data$Id)
n_distinct(sleep$Id)
n_distinct(weight$Id)

# Order the days of the week
combined_data$Weekday <-factor(combined_data$Weekday, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))


# Select summary statistics 
combined_data %>%
  select(TotalMinutesAsleep, TotalSteps, TotalDistance, VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes, Calories, WeightKg, Fat, BMI, IsManualReport) %>%
  summary()

# Total steps by day 
ggplot(data=combined_data, aes(x=Weekday, y=TotalSteps)) + 
  geom_bar(stat="identity", fill="#fa8072")+
  labs(title="Steps by Day", y="Total Steps") 
  
# Minutes of moderate activity per day 
ggplot(data=combined_data, aes(x=Weekday, y=FairlyActiveMinutes)) + 
  geom_bar(stat="identity", fill="#fa8072")+
  labs(title="Fairly Active Minutes by Day", y="Minutes") 

# Logged Activities Distance 
ggplot(data=combined_data, aes(x=Weekday, y=LoggedActivitiesDistance)) + 
  geom_bar(stat="identity", fill="#fa8072")+
  labs(title="Logged Activity Distance by Day", y="Logged Activity Distance") 

# Distribution of sleep time 
ggplot(combined_data, aes(TotalMinutesAsleep)) +
  geom_histogram(bins=10, na.rm=TRUE,color = "#000000",fill="#fa8072" )+
  labs(title="Distribution of Total Time Asleep", x="Total Time Asleep (minutes)") 

# Total minutes Asleep vs Calories
ggplot(combined_data) +
  geom_point(mapping = aes(x=TotalMinutesAsleep/60, y=Calories), na.rm=TRUE, color="#fa8072") +
  labs(title="Calories vs Time Slept", x="Time Asleep (Hours)", y="Calories") 

# Export data to excel file 
write.xlsx(combined_data, file="Fitbit_Fitness_Data.xlsx")


