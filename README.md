# DS_3_w4_cp

This script is very simple
First, it load data from txt-files to tables
     , add column names
     , merge information about activities and subject with information about measures
       
Then this script do five steps/
step1: Merge two sets of data. Train and Test
step2: Select measures with mean and std. (select only colums wich consist sdv() or mean() in their names)
step3: Create new column for activity that consist a normal names of activities (Before our table have colums with activity code)
step4: Cleaning column names (Cleaning from "-", " ", etc. And change "t" to "Time", and "f" to "Freq"...)
step5: Create final set and write it to file (Another table with average values for each column group by Subject and Activity)
