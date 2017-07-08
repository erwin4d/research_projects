#########################################################
################### BTRY 3520 ###########################
################## Homework 5 ###########################
############# Due: May 10, 2017 #########################
#########################################################


# Instructions: save this file in the format <NetID>_HW5Q3.R. 
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

## NOTE: For this homework we are having you submit 
## separate files for each question (this helps us with
## processing time on the autograder). There are three questions
## in this homework, given in separate files, and you should
## submit one file per question. 




########################################
# Question 3:  Statisticans Play Darts #
########################################

# This problem was inspired by a paper of the same name by Tibshirani, Price and Taylor in 
# the Journal of the Royal Statistical Society, Series A in 2011. This is also available on 
# CMS for those of you who are interested.

# Darts is a common pub game across much of the world. It consists of a circular board cut into
# 20 slices. A diagram of the board is posted on CMS. Participants throw a dart at the board and 
# receive the points in the slice they hit. These slices are worth points 1 through
# 20, but these numbers are arranged in a roughly alternating fashion. In addition to the slices,
# there are four rings that alter the score. A central circle (the bullseye) is worth 50 points, a
# ring around that is worth 25 points. There are then thin rings around the middle of the slices
# and one around the edge. The first of these triples the score, the second doubles it. You get
# zero points for not hitting the dartboard.

# A standard board is 340mm across and we will place it on the region [-170,170] in both x and
# y co-ordinates. The rings correspond to radii at 6.35mm, 15.9mm, 99mm, 107mm, 162mm and 170mm.
# We will think of the score from the dartboard as a function f(x; y) of the location of the dart
# in the x-y plane. The file DartBoard.R on Blackboard takes in values x and y and returns
# the value of the score. It has been written to allow you to give it vectors and will return a
# vector of scores as well.

source('DartBoard.R')

# The goal of this question is the following. Very few people are perfect darts throwers and can
# hit their target exactly (this is especially so of your professor). The perfect thrower would aim
# for the middle ring in the 20 slice, thus gaining 60 points. Where should an imperfect thrower
# aim, knowing that they will likely have some random error in what they hit? We will assume
# this thrower is trying to maximize their expected score.

# A) For this question we assume that the thrower aims at a point mu = (mu_1,mu_2), but their
# actual thrower's distribution is N(mu; sigma^2) where they aim at mu but where they actually
# hit is random with normal distribution about mu and variance sigma^2 in each direction.

# i. Write a function to produce a Box-Muller algorithm that returns two-dimensional
# normal random variables with mean mu and variance sigma^2.

bivar.rnorm = function(n,mu,sigma){

return(X)
}

# ii. Using this function, produce a Monte Carlo estimate of the expected score of a thrower
# aiming at the bullseye who has variance 400 (standard deviation 20). Use 100,000
# points.


Escore = 

# B) Taking the Monte Carlo estimate above to be the true integral, we will use this in pro-
# ducing a control variate for estimates at other locations. In particular, use 1,000 points
# to estimate the expected score of someone who aimed at (-20,-20) with a vanilla Monte
# Carlo estimate and using the estimated score at (0,0) as a control variable.

# You should do this by generating two-dimensional N(0; I) random variables. If you label
# these E then use 20*E - 20 to obtain random variables with mean (-20,-20) and standard deviation
# 20; use 20E for random variables with mean (0,0) and standard deviation 20. Use the same original
# random numbers to obtain a control-variate correction. Do this by setting the seed to
# be 402 each time you generate your random numbers. Write a function to calculate this estimate for any
# mean vector mu and return the result with and without control variate 

ExpectedScoreCV = function(mu=c(-20,-20), npts=1000, expected_score = Escore){


return( list(withControl = ,  noControl= ) )
}


# Estimate the expected score with the control variate


CVEscore.m20 = ExpectedScoreCV()$withControl



# Conduct a simulation of 100 estimates of your integrals and report ration the variance of the
# vanilla Monte Carlo estimate to the variance of the estimate where you used a control variate.

var.ratio = 


# C) Produce a 21-by-21 matrix of the expected values at a grid of 21 points in x (rows) and 21 points
# in y (columns).

ScoreMatrix = 

# Produce a contour plot of these scores and mark the point that this person should aim for. 

