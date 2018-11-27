function [dist_struct] = get_pairwise_squared_lp_even_distance(X1, X2, p)

  % X1, X2:A structure with at least two fields, being
  %           .mat: A n by p matrix with n observations and p features
  %           .num_obs: Number of observations
  %           
  %  p, which could take positive even integers 2,4,6,...

  % dist_struct: Outputs a structure with three fields.
  %            .dist_mat:  A n1 by n2 matrix, with (i,j)^th entry being the 
  %                        squared lp distance between X1(i,:) and X2(j,:)
  %            .dist_type: 'squared_lp_distance' 
  %            .dist_p   : p
  % Assumptions: Assume we can compute and store this n1 by n2 matrix in memory
  
  % Author: KK

  % See derivations.pdf for more info
 
   
 
  if mod(p,2) == 0

    dist_struct.dist_mat = repmat(sum((X1.mat).^p,2),1,(X2.num_obs)) + repmat(sum((X2.mat).^p,2),1,(X1.num_obs))'; % take care of M_0 and M_p (see derivation)

    for t = 1:(p-1)
      dist_struct.dist_mat = dist_struct.dist_mat + (-1)^t * nchoosek(p,t) * ((X1.mat).^t * ((X2.mat).^(p-t))');
    end

    dist_struct.dist_type = 'squared_lp_distance';
    dist_struct.dist_p = p;
  else
    'error';
    dist_struct = 'error';
  end

end
      
  