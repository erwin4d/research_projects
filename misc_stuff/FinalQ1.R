#########################################################
################### BTRY 3520 ###########################
################## Final Exam ###########################
############# Due: May 23, 2017 #########################
#########################################################


# Instructions: save this file in the format <NetID>_FinalQ1.R. 
# Complete each question using code below the question number.
# You need only upload this file to CMS. 

# Note, we assume your working directory contains any files
# that accompany this one. 

# Further note: 10% will be deducted if your file produces
# an error when run. If your code produces an error and you 
# cannot find it, comment out that portion of the code and we
# will give partial credit for it. 

# Do not use the function set.seed() or rm(list=ls())
# or setwd() in your code. 

# NOTE: There are three questions given in separate files, and 
# you should submit one file per question. 

#### IMPORTANT INSTRUCTIONS FOR THE FINAL

## The final is to be completed as though it were in-class. 
## That means 
##
## 1. You must complete this work independently, without 
## collaboration or external assistance. Violations will
## be treated under the academic code. 
##
## 2. We will not provide office hours. We will monitor 
## Piazza and provide clarifications where questions are
## unclear. 
##
## 3. While we will not, in general, debug your work for you,
## we are happy to try to explain error messages if you can
## isolate the line of code that produces them and, preferably,
## reproduce them with a few-line script.
##
## [Example: R tries to interpret dimensions, but doesn't 
## always get it right.  So the code
##  
##   b = matrix(2,1,1)
##   t(1:3)/b
##
##  returns an error, but (1:3)/b does not.  We think it reasonable
##  to explain something like this to you if you get a message
##
##   Error in t(1:3)/b : non-conformable arrays
##
##  along with other instances of "I know where the error is, I just
##  don't know why R has a problem or how to fix it"]


## QUESTION 1: Option pricing

# In this question we will examine Asian options, which allow a
# buyer to guarantee the average price of a commodity (or a stock) over
# some time period.

# Prices are generally modeled as following a geometric random
# walk. For parameters mu and sigma, this follows
#
# X_{t+1} = X_t * exp( mu - sigma^2/2 + sigma*e_t)   (*)
#
# where e_t ~ N(0,1). 

# For our model we'll consider the problem of a yoghurt manufacturer
# who must purchase milk on a daily basis. In order to guarantee a 
# stable price, they purchase an Asian option. Our task is to figure
# out a fair price for this option. 


# A) Write a function to simulate the price of one gallon of milk. 
# This function should simulate N replicates of a future over ndays
# starting from $x0/Gallon with parameters mu and sigma. 
#
# It should return a nday-by-N matrix of future prices


StockSimulation = function(x0,mu,sigma,nday,N){

}


# i) Use this to simulate 1000 stock prices over 100 days with mu = 0.001, 
# sigma = 0.05 starting at $1/gallon.  Produce a plot of the distribution of
# prices over the 100 days.  The plot should have time on the X-axis and consist
# of three lines:
#
#  - the average value of the price on each day
#  - the 2.5% quantile of the price value on each day
#  - the 97.5% quantile of the price on each day 
#
# Upload this graph to CMS as StockPrice1.png. 




# ii) One criticism of a plot such as in part (i) is that it only gives a sense
# of the spread of the possible stock prices each day, not over the whole time. 
# 
# For example, what percentage of the stock prices you simulate go outside of the
# 2.5% and 97.5% quantiles that you calculated SOMETIME during the 100 day period?


PercentOutside = 

# We can try and produce uniform intervals by looking at the maximum of a 
# standardized statistic. 
#
# That is, calculate the standardized price each day. For each stock, subtract 
# the average stock price for that day and divide by the stock standard deviation
# for that day. This will give you a set of standaridized prices that have mean zero
# and variance 1 for each day, but which will still vary over days. 

# Note that the standard deviation at day 1 will be zero. You will need to re-set this
# standardized price to zero on that day. 



# iii) Now take a maximum and minimum over time for each stock (so you have 1000 maxima
# and 1000 minima). Report the 2.5% quantile of the minima and the 97.% percent
# quantile of the maxima. 

Min2.5 = 

Max97.5 = 

# Now reproduce the graph from part (i), but add two more lines giving 
#
# mean + Min2.5 * standard deviation
# mean + Max97.5 * standard deviation
#
# (note that since Min2.5 should be negative, we do add it to the mean).
# Upload this figure as StockPrice2.png



# iv) What percentage of the prices fall outside these wider intervals at
# some day?


PercentOutside2 =


# B) We will now examine the price of an Asian option. Here the option
# guarantees the maximum average price that the yoghurt company will
# need to pay. That is, if you issue an option with price guaranteed 
# at $K, the cost you face is 
#
#    average price - K    if   average price > K
#
# if the average price is below K, you face no costs. 

# Write a function that takes simulated stock prices and returns
# the cost of the option for each simulation  (that is, it should
# return a vector of length N) when the strike price is K:

payout = function(X,K){
   
}

# Use this to create a vector of option prices for 

K = seq(0.6,2,by=0.2)

# using the simulation you have already conducted. 

PayK = 

# Estimate the standard deviation of each value in this vector
# (ie, provide a vector of standard deviations). You should not need to
# simulate more stock prices for this. 

PayKsd = 



# C) Here we will consider ways to improve the efficiency of the 
# simulation of stock prices. One way to do this might be to use
# antithetic random variables when creating the stock price. 

# That is we simulate prices in pairs:
#
#    X_{t+1} = X_t * exp( mu - sigma^2/2 + sigma*e_t)   
#    Y_{t+1} = Y_t * exp( mu - sigma^2/2 - sigma*e_t)   
#
# where the same e_t ~ N(0,1) is used for both X and Y. The idea
# being that when X moves up by random chance, Y will move down. 


# Write a function to simulate a total of N replications of the
# stock price, but where the replications come in antithetic X,Y 
# pairs. (N can be assumed to be even). It should otherwise have
# the same structure, including what it returns, as StockSimulation()


StockSimulationAnti = function(x0,mu,sigma,nday,N){

	
}

# i) Use this function to simulate a total of 1000 stocks in 
# antithetic pairs with the same parameters as above and 
# obtain alternative estimates for the fair price of the 
# option based on these




PayKa = 

# ii) Using only these simulations, give the ratio of the 
# standard deviations of your estimates of the stock price
# when K = 1 when we average of the first 2 days,
# 10 days, 20 days, 50 days and 100 days. (Use antithetic as
# the numerator.)

# Note that to estimate the standard deviation of the antithetic
# sampling, you should first average the antithetic pairs, and then 
# look at the standard deviation over pairs. 


SDRat = 


# Does the same variance reduction hold when K = 1.2. Evaluate
# the same ratio for this strike price (you will probably get an 
# NA for 2 days because the payout will alwyas be 0). 

SDRat1.2 = 


# D) Rather than taking the average over 100 days, the company would
# like to garuantee the average price in each 10 day period. This is 
# because their income comes in at 10 day periods. To provide certainty
# however, they wish to guarantee that cost over a 100 day period. 
#
# That is, the option pays the difference between the average price
# in each 10 day period and the strike price (if this is positive), summed
# over the periods. 

# Write a function to evaluate the cost of this option for each simulated
# stock.

payout2 = function(X,K){
	
}

# Estimate the fair price of this option at the strike prices
# used in Part B and the (non-antithetic) stocks you have already
# simulated. 

Pay2K = 

# E) So far, we have only discussed the cost of an option on 
# one gallon of milk. In fact, the producer needs to buy a 
# random amount of milk each day. This has historically fit a 
# Poisson distribution with mean 100 each day and the purchase
# quantity is independent from day to day and independent of
# the price of milk. 
#
# Write a function that calculates a new version of payout 2
# in which the payout in each 10 day period is the difference in
# total costs actually incurred and the costs at $K per Gallon. 
#
# When you do this, you should give each stock simulation its 
# own sequence of purchase volumes. 


payout3 = function(X,K){
    
}

# Provide estimates of the cost of this option for the 
# strike prices in Part B using the simulated non-antithetic
# stock prices. 

Pay3K = 


# F) As the seller of the option, you are aware of production 
# changes that will likely affect the price of milk over the 
# life of the option. You aren't sure about exactly how this 
# will effect the price but you expect the average price to 
# climb to about $1.3/Gallon. When asked to estimate your 
# uncertainty about this, you are prepared to model the range
# of possible outcomes as N(1.3,0.2). 
#
# This is not a formal prior, but we can evaluate the effect of
# this knowledge in the following way:
#
# 1. For each simulation calculated the average price over 
# the simulation. 
#
# 2. Obain the payout from each simulation. In this case we'll
# use the payout from Part D. 
#
# 3. Obtain a weighted mean of the payouts with weights given
# by the N(1.3,0.2) density evaluated at the average price. 
#
# you may find the weghted.mean() function useful. 

# Use this to estimate the cost of the option at K = 1.1
# before taking this knowledge into account


Cost1.1prior = 

# and after

Cost1.1after = 


# We may be interested in examining the range of possible outcomes. 
# One way to obtain a distribution after taking into account
# the new information is to re-sample the payouts (with replacement) 
# with the weights above used to make payouts with mean closer
# to 1.3 more likely to be sampled.
#
# In the sample() function, the option 'prob' allows you to set 
# sampling weights. 

# Obtain a vector of prices re-sampled in this way and produce 
# a plot with two panels (stacked vertically) giving a histogram of
# the prices before sampling and after with 100 bins in each plot. Make 
# sure both plots have the same range on the x-axis. Upload this to CMS 
# as OptionPrices.png.



