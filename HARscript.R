library(plyr)
library(dplyr)
library(tidyr)
features <- read.table("features.txt")
features <- select(features, -1)
activity <- read.table("activity_labels.txt")
activity

subject_test <- read.table("subject_test.txt")
subject_train <- read.table("subject_train.txt")
subject <- bind_rows(subject_test, subject_train)
subject <- data.frame(subject)
colnames(subject) <- "Subject_code"

y_test <- read.table("y_test.txt")
y_train <- read.table("y_train.txt")
y <- bind_rows(y_test, y_train)
y <- as.factor(y$V1)
y2 <- revalue(y, c("1" = "WALKING", "2" = "WALKING_UPSTAIRS", "3" = "WALKING_DOWNSTAIRS", "4" = "SITTING", "5" = "STANDING", "6" = "LAYING"))
y2 <- data.frame(y2)
colnames(y2) <- "ActivityName"
y2$ActivityLabel <- y
colnames(y2)
glimpse(y2)

X_test <- read.table("X_test.txt")
X_train <- read.table("X_train.txt")
x <- bind_rows(X_test, X_train)
colnames(x) <- features[ , 1]


colnames(x) <- make.names(colnames(x), unique = TRUE)
data_slim <- select(x,
               contains("mean"),
               -contains("meanFreq"),
               contains("std"))
all_data <- bind_cols(subject, y2, data_slim)
glimpse(all_data)
