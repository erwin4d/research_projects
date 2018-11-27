function [dist_struct] = get_pairwise_squared_lp_distance(X1, X2, p)

  % X1, X2:A structure with at least two fields, being
  %           .mat: A n by p matrix with n observations and p features
  %           .num_obs: Number of observations
  %           
  %  p, which could take positive integers 1, 2, ... including Inf

  % This combines the functions
  %  - get_pairwise_l1_distance
  %  - get_pairwise_squared_lp_even_distance
  %  - get_pairwise_squared_lp_odd_distance
  %  - get_pairwise_l_infinity_distance

  % Assumptions: Assume we can compute and store this n1 by n2 matrix in memory
  
  % Author: KK

  % See derivations.pdf for more info
  
  if p == 1
    dist_struct = get_pairwise_l1_distance(X1,X2);
  elseif mod(p,2) == 0
    dist_struct = get_pairwise_squared_lp_even_distance(X1,X2,p);
  elseif mod(p,2) == 1
    dist_struct = get_pairwise_squared_lp_odd_distance(X1,X2,p);
  elseif p == Inf
    dist_struct = get_pairwise_l_infinity_distance(X1,X2);
  else
    'Error'
  end

end
      
  