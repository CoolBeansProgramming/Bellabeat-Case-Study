# Data Documentation and Data Dictionary 

## FitBit Fitness Tracker Data

The Data Dictionary can be found [here](https://www.kaggle.com/datasets/arashnic/fitbit/discussion/281341)

`dailyActivity_merged.csv `
* Description: Contains daily totals for steps, intensity, distance, and calories
* Format: Long 

* Fields:
*   ActivityDate: date value in mm/dd/yyyy format
*   TotalSteps: total number of steps taken 
*   TotalDistance: total kilometers tracked
*   TrackerDistance: total kilometers tracked by Fitbit device
*   LoggedActivitiesDistance: total kilometers from logged devices
*   VeryActiveDistance: kilometers travelled during very active activity
*   ModeratelyActiveDistance: kilometers travelled during moderate activity
*   LightActiveDistance: kilometers travelled during light activity 
*   SedentaryActiveDistance: kilometers traveled during sedentary activity
*   VeryActiveMinutes: total minutes spent in very active activity 
*   FarilyActiveMinutes: total minutes spent in light activity 
*   LightylActiveMinutes: total minutes spent in light activity 
*   SedentaryMinutes: total minutes spend in sedentary activity 
*   Calories: total estimated energy expenditure (kilocalories) 




`sleepDay_merged.csv`
* Description:  Data from each tracked sleep event
* Format: Long 

* Fields: 
*   SleepDay: Date on which the sleep event started
*   TotalSleepRecords: Number of recorded sleep periods for that day; includes napes > 60 minutes 
*   TotalMinutesAsleep: Total bumber of minutes classified as being "asleep"
*   TotalTimeInBed: Total minutes spent in bed, including asleep, restless, and awake, that occurred during the defined sleep record 

* Notes: Sleep durations are either specified by Fitbit wearer (interacting with the device or
Fitbit.com profile), or are automatically detected on supported models (Charge, Alta, Alta HR
Charge HR, Flex, Blaze, Charge 2, Flex 2, Ionic, and Surge). Sleep Stages are supported by
the Alta HR, Charge 2, Blaze, and Ionic. All other devices support the Classic sleep algorithm.
