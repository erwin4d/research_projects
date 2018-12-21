function [ rmse ] = compute_RMSE_mult_array(truevals, estvals, N)
  
  % truevals should be a 2 dimensional array of obs x obs 
  % estvals should be a 3 dimensional array of obs x obs x k
  % N should be number of total pairwise observations

  rmse = sqrt(sum(squeeze(sum((estvals - truevals).^2,1)),1) / N);
  


end

