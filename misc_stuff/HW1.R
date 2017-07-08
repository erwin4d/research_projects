#########################################################
################### BTRY 3520 ###########################
################## Homework 1 ###########################
############# Due: Feb 17, 2017 #########################
#########################################################


# Instructions: save this file in the format <NetID>_HW1.R. 
# Complete each question using code below the question number.
# You need only upload this file to CMS. 

# Note, we assume your working directory contains any files
# that accompany this one. 

# Further note: 10% will be deducted if your file produces
# an error when run. If your code produces an error and you 
# cannot find it, comment out that portion of the code and we
# will give partial credit for it. 

# Do not use either the function set.seed() or rm(list=ls())
# in your code. 

#######################################
# Question 1:  (from JMR 3.12, pg 46) #
#######################################

# Note that there are two versions of this question in two different
# editions of JMR. The authorotative version for this question is 
# transcribed as

## The dice game craps is played as follows. The play throws two dice , and if
## the suym is seven or eleven, then he wins. If the sum is two, three, or twelve,
## then he loses. If the sum is anything else, then he continues throwing until 
## he either throws that number again (in which case he wins) or he throws a seven
## (in which case he loses). 

## Write a program to simulate a game of craps. You can use the following
## snippet of code to simulate the roll of two (fair) dice:

## x <- sum( ceiling( 6*runif(2) ) ) 

# In particular, write code below to simulate n = 50 games of 
# craps and store the number of games won in an object called 
# `nwins`. 





nwins = 



###################################
# Question 2: Oh Rats!            #
###################################

# The file rats.csv contains data on the size (measured in 
# head diameter) of rats distributed into three groups. Each
# row gives
#
#   - SUBJECT: an individual number fo each rat
#   - GROUP: which experimental group the rat belogs to; these
#            differ in the diet given to the rats
#   - RESPONSE: the rats head size
#   - TIME: the age of the rats in days
#
# The size of each rat is measured every 10 days. 

# This is loaded in here

rats = read.csv('rats.csv',head=TRUE)


# A)  Write Code that reads in this data file and re-arranges it
# into a hierarchy of lists:
# 
#   - the first list has three elements, one for each group 
#   - each element of this list is itself a list with one element
#      for each rat in the group
#   - each rat is a list of two elements: a vector of observation times
#     and a vector of responses. 
#
# Check that your lists are in numeric order by their labels (it may be useful 
# to turn these labels into factors). 
#
# Your final object could be called RatList




RatList = 



# B) Write a function called PlotGroup that plots a Group. It should take in 
# your answer from Part A and extract all the rats in the group. The data for 
# each rat should be plotted as a line. 

# Color the rat with the largest final observation differently 
# from the others. 

# Use this function to plot Group 2; save this plot as a .png file and upload
# it to CMS. (You can save a plot from the File menue of the plot window). 

PlotGroup = function(RatList,groupnum){



}



# C) Write a function of three arguments: RatList, Group number and 
# Rat number (where each group has rat labels starting from 1). The function should 
# extract the data for this rat, perform linear regression to predict RESPONSE from 
# TIME and report the slope of the regression. Your function should return just the 
# number giving the slop for that rat. Check this on Group 3 rat 2. Recall that
# the function `lm` performs linear regression. 


RatSlope = function(RatList,groupnum,ratnum){


}





###################################
# Question 3: JMR 6.4, pg 107     #
###################################

# Recall that Pascal's triange is of the form
#      
#       1
#      1 1
#     1 2 1
#    1 3 3 1
#
# Where in row i, each element is the sum of the two diagonally above it in row i-1. 

# Your first function should evaluate the (n+1)st Pascal triangle given the nth as an 
# input and return in the same format (see text question)

PascalPlus1 = function( triangle ){


}


# Using this function, write a function that obtains the nth Pascal triangle. 

PascalToN = function(n){


}

# For this you can assume you start with the first two rows of the triangle

pascal1 = list( c(1), c(1,1) )

# Verify the final row of your answer for n = 11 by checking with the binomial
# coefficients given by `choose(10,i)` for i = 0:10.  







###################################
# Question 4: Numerical Stabiilty #
###################################

# A mathematician requires the calculation of the integral
#
#  y[n] = \int_0^1 x^n exp(x) dx 
#  
# where \int_0^1 means the integral with limits 0 and 1. 


# A) Using integration by ports, show that y[n] satisfies the recursion
#
#     y[n+1] = e - (n+1) y[n]
#
#  (you may write this in comments, using y' to indicate the derivative of y. 

# This potentially makes for an efficient means of calculating the integral!




# B) Write a function that uses this recursion to calculate y[n]. Use this to produce a 
# vector of these values for n = 1:20 in the object YInt


IntFunc = function(n,y){


}


Yint = 



# C) How can you tell from your output that this is porrly conditioned? (You may
# respond in comments below. 




# D) How large do you expect the absolute error of y[20] to be? Why? (Explain in
# comments). 











###################################
# Bonus: JMR 5.4                  #
###################################

# The function below gives misleading outputs

random.sum <- function(n) {
    # sum of n random numbers
    x[1:n] <- ceiling(10*runif(n))
    cat("x:", x[1:n], "\n")
    return(sum(x))
}

x <- rep(100, 10)

# For example, try

show(random.sum(10))
show(random.sum(5))

# Fix this function so that it does what it says it does. Note in comments below
# which lines you fixed and why they would not work.   You may provide your answers
# with this function commented out. 
