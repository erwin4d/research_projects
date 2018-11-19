function [dist_struct] = get_pairwise_angular_distance(X1, X2)

  % X1: n1 by p matrix of n1 observations and p parameters 
  % X2: n2 by p matrix of n2 observations and p parameters

  % dist_struct: Outputs a structure with two fields.
  %            .dist_mat:  A n1 by n2 matrix, with (i,j)^th entry being the 
  %                        angular distance between X1(i,:) and X2(j,:)
  %            .dist_type: 'angular_distance'
  %                                                                                                              
  % Assumptions: Assume we can compute and store this n1 by n2 matrix in memory
  % Assumptions: No observations are zeros 

  % Author: KK

  % See derivations.pdf for more info

  % Note: Possible to get NaNs here, when one vector is zero so...
  
  n1 = size(X1,1);
  n2 = size(X2,1);

  dist_struct.dist_mat = acos((X1 * X2') ./ sqrt(repmat(sum(X1.^2,2),1,n2) .* repmat(sum(X2.^2,2),1,n1)'));
  dist_struct.dist_type = 'angular_distance';


end
      
  