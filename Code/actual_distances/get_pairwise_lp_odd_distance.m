function [dist_struct] = get_pairwise_lp_odd_distance(X1, X2, p)

  % X1, X2:A structure with at least two fields, being
  %           .mat: A n by p matrix with n observations and p features
  %           .num_obs: Number of observations
  %           
  %  p, which could take positive odd integers starting from 3,5,7,...

  % dist_struct: Outputs a structure with three fields.
  %            .dist_mat:  A n1 by n2 matrix, with (i,j)^th entry being the 
  %                        lp distance between X1(i,:) and X2(j,:)
  %            .dist_type: 'lp_distance' 
  %            .dist_p   : p
  % Assumptions: Assume we can compute and store this n1 by n2 matrix in memory
  
  % Author: KK

  % See derivations.pdf for more info
  if(mod(p,2) == 1)
    dist_struct = get_pairwise_squared_lp_odd_distance(X1, X2,p);
    dist_struct.dist_mat = nthroot(dist_struct.dist_mat,p);
    dist_struct.dist_type = 'lp_distance';
  else
    'error';
    dist_struct = 'error';
  end

end
      
  