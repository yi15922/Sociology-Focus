## Qualtrics Data Cleaning and Exploratory Analysis
## 11.28.2018


#First, let's install some packages that will help with the data cleaning and analyzing


library("dplyr")
library("ggplot2")


#Set your working directory to the place where you saved the Qualtrics file

#setwd("C:/Users/jmq4/Desktop") #Note: if you're on a mac, the directory path should look a little 
#different...


#Let's use this function to read in the qualtrics file and store it to an object we'll call "dat"
dat <- read.csv(file = "data/numeric.csv", stringsAsFactors = F, header=TRUE) 
#NOTE: ^^this is the "numeric values" version of the qualtrics csv file


#the file is a little too messy to take a peek at with the head() function, and many qualtrics 
#files are too big for View() - so let's combine them
class(dat$concept3_E_1)
View(head(dat))

#Cool, we have data!
#Let's pause here to think about some best practices on data management before we dive 
#into our results. Mistakes you make here can really mess up your findings! You don't 
#need to be a seasoned programmer to be careful - you simply need to check your work. 
#Here are some general guidelines:

#0) be careful about overwriting data frames (and other objects)

dat <- dat[-(1:2),]
#^^this deletes the first three observations (rows) in the data frame
#"dat"...but it permanently writes the tweaked version of "dat" over the
#original. So if I accidentally deleted observations with real respon-
#dent data, those records would not be included in my results.

#it would be safer to assign edits to a new object, like the line below:

#datB <- dat[-2] #(don't run - "dat" has already been edited in the line above)

#...but if your file is huge, R has to remember both dat and datB now.
#In short, make different copies of your data whenever you're about to
#A) make a major/risky change or B) aren't SURE about what the code will 
#do


#1) always check out your data

dplyr::glimpse(dat) #the vectors (variables) are all "factors" - is this what we want? IRL, 
#some of them  will need to be numeric for our analyses; others can stay 
#as factors or could be better off as character vectors...

#you can tweak how you read things in with the read.csv() function, but 
#this is good enough for now.


#2) give variables names that make sense

head(names(dat), 100) #Default qualtrics names make no sense without a codebook.
#My survey has 600+ items so I won't rename now, but it's
#a good call to rename at least the variables you're going to
#work with. Here's how:

#let's say I want to rename Q527-Q527 (the 37th-39th variables in my data drame)...
colnames(dat[35:40]) #look at names before

#colnames(dat)[37:39] <- c("HowOftenVoteLocal", "HowOftenGotInfo", "AD_AmDemWorking")

#colnames(dat[35:40]) #look at names after - again, careful when making permanent changes

summary(dat[,37])
summary(dat$HowOftenVoteLocal) #both of these lines show the same thing

dat <- dat %>%
  select(-IPAddress, -StartDate, -EndDate, Status, -Duration..in.seconds., 
         -RecipientEmail, -ExternalReference, -RecipientFirstName, -RecipientLastName, 
         -LocationLatitude, -LocationLongitude, -DistributionChannel, -UserLanguage, -Agree, 
         -comments, -gender_6_TEXT, -RecordedDate)

names(dat)

#as.numeric(dat$HowOftenVoteLocal)

#mean(dat$HowOftenVoteLocal) #this doesn't work. Why?

#class(dat$HowOftenVoteLocal) #Ah


#3) keep track of what your numeric values mean

#one of the drawbacks to R is the absence of a variable labeling system
#For example, if you ask a respondent to rank how happy they are on a 
#scale from 1 to 5, where 1 is "not at all happy" and 5 is "extremely
#happy," R can't quickly tell you what those values mean. There are
#work-arounds, but for now you should keep your qualtrics survey report
#window open so you know how to interpret the values.




#4) don't overwrite variables when you "recode" them

#Researchers "recode" (assign new values) to variables for many reasons.
#This is where some famous mistakes have been made. To avoid that, just don't
#overwrite the original measure.






