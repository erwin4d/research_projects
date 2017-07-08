#########################################################
################### BTRY 3520 ###########################
################## Final Exam ###########################
############# Due: May 23, 2017 #########################
#########################################################


# Instructions: save this file in the format <NetID>_FinalQ2.R. 
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





## QUESTION 2: Time-Series, the Bootstrap, and MCMC

# In this question we will examine what to do about bootstraping a
# auto-regressive model. We will base this around temperature data for June, 1994
# from Montreal (mostly because Giles had it easily to hand). 

# The data can be loaded as follows:

montemp = read.table('montrealJune1994.dat')[[1]]

# A) These data come in order from June 1 to June 30 so that we think of them
# as coming X_1,X_2,...,X_30 according to the days of the month. 
#
# While weather services will use complex models based on physically-understood
# mechanisms to forecast weather, a statistician might look at these data
# and suggest a model of the form
#
# X_{t+1} = beta_0 + beta_1 X_t + epsilon_t
#
# This is an auto-regressive model of Order 1 because we predict today's 
# temperature from yesterday's (Giles can give you a rant about statistician's 
# love of linear models and its pernicious effects on science if you want). 
#
# Fit this model for these data using the lm function. 

armod = 


# B) In Homework 3 we examined the residual bootstrap. It would be tempting
# to apply this here, but we notice that if we change epsilon_1, say, then 
# we have also changed the the value of X_2, from which we will then try to 
# predict X_3 and so forth. 
#
# Instead of simply applying the residual bootstrap, we will resample the
# residuals, but then propagate the effects through the whole data set. 
# 
# That is, we will 
#
# 1. Obtain residuals e_i as  X_{t+1} - beta_0 - beta_1 X_t from our fitted 
#    model. Call this ar.err.
#
# 2. Obtain a bootstrap sample of these to get e*_1,...,e*_29 (e*_i indicating
#    that it has been resampled -- there are only 29 steps from the first
#    time point) 
#
# 3. Generate a bootstrap data set by using 
#
#             X*_{t+1} = beta_0 + beta_1 X*_t + e*_t
#
#    that is, build up the process starting from X_0 (which is the same for
#    all boostraps) using the e*_t. 
#
# 4. Re-fit beta0 and beta1 to obtain a bootstrap distribution. 

# Carry out this scheme with 1000 bootstrap replicates and produce 


ar.err = 




# i) A vector giving the means of the bootstrap samples of beta_0 and beta_1

ar.bootmean = 


# ii) Bias corrected estimates

ar.coef.corr = 

# iii) Normal theory confidence intervals centered on the bias corrected
# estimates

ar.beta0.confint = 

ar.beta1.confint = 





# C) An alternative approach to inference involves a Bayesian approach. 
#
# For this approach, we specify a model for our data. In this case
#
#    X_{t+1} ~ Normal( mean = beta0 + beta1 X_t,  sd = sigma)
#
# and add to this prior beliefs about the parameters beta0, beta1 and sigma. 

# In this case, we will use 
#
#    beta0 ~ Normal(mean = 0, sd = 100)
#    beta1 ~ Normal(mean = 0, sd = 1)
#    log(sigma) ~ Normal(mean = 0, sd = 10)

# We then say that, jointly, the X_t and beta0, beta_1, sigma have a 
# distribution that is given by the product of all of these densities:
#
# [prod N(X_{t+1},beta0 + beta1 X_t,sigma)] N(beta0,0,100) N(beta1,0,1) N(log(sigma),0,10)
#
# and we can now ask about the conditional distribution of beta0, beta1 and sigma with
# the X_t held fixed (their observed, after all). 

# To do this, we would need to find a normalizing constant, which is difficult, but
# we can simply simulate from this distribution using a random walk MCMC. 

# i) Write a function to evaluate the log posterior for theta = (beta0,beta1,log(sigma))
# and a data vector X (we will use montemp below) 


logposterior = function(theta,X){
	
}

# We'll check this with natural point estimates of our parameters

thetastart = c(armod$coef,log(sd(ar.err)))

start.post = logposterior(thetastart,montemp)


# ii) Write  a function to implement a random walk MCMC with inputs
#
# theta0 - the starting vector of parameters
# nstep  - the number of MCMC steps to take
# sds    - a vector of standard deviations for the random walk in each parameter
# X      - a data vector
#
# it should return a list with 
#
# thetavals - a matrix giving the values of theta generated
# acc       - the acceptance rate
# logpost   - the values of the posterior for each step.

rwmcmc = function(theta0,nstep,sds,X){

}

# iii) Run this for 10,000 steps using random walk standard deviations
# of 

sds = c(100,1,10)/40

ar.result = 

# what is the acceptance rate?

ar.acc = 

# iv) Using every 10th value of your resulting thetavals find the 



# a vector giving posterior mean of each of the parameters

ar.postmean = 

# credible intervals for beta0 and beta1

credint.beta0 = 

credint.beta1 = 

# a credible interval for sigma (not log(sigma))

credint.sigma =

# v) Produce a scatter-plot of beta0 and beta1 based on every
# 10th value of your chain. Mark in red the values you obtained
# from lm. Upload this to CMS as  posterior.png. 



