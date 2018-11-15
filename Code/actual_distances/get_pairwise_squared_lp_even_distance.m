function [dist_struct] = get_pairwise_squared_lp_even_distance(X1, X2, p)

  % X1: n1 by p matrix of n1 observations and p parameters 
  % X2: n2 by p matrix of n2 observations and p parameters
  %  p, which could take positive even integers 2,4,6,...

  % dist_struct: Outputs a structure with three fields.
  %            .dist_mat:  A n1 by n2 matrix, with (i,j)^th entry being the 
  %                        squared lp distance between X1(i,:) and X2(j,:)
  %            .dist_type: 'squared_lp_distance' 
  %            .dist_p   : p
  % Assumptions: Assume we can compute and store this n1 by n2 matrix in memory
  
  % Author: KK

  % See derivations.pdf for more info
  
  n1 = size(X1,1);
  n2 = size(X2,1);
  
  dist_struct.dist_mat = repmat(sum(X1.^p,2),1,n2) + repmat(sum(X2.^p,2),1,n1)'; % take care of M_0 and M_p (see derivation)

  for t = 1:(p-1)
    dist_struct.dist_mat = dist_struct.dist_mat + (-1)^t * nchoosek(p,t) * (X1.^t * (X2.^(p-t))');
  end

  dist_struct.dist_type = 'squared_lp_distance';
  dist_struct.dist_p = p;

end
      
  