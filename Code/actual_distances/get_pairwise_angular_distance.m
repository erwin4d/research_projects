function [dist_struct] = get_pairwise_angular_distance(X1, X2)

  % X1, X2:A structure with at least two fields, being
  %           .mat: A n by p matrix with n observations and p features
  %           .num_obs: Number of observations
  %           

  % dist_struct: Outputs a structure with two fields.
  %            .dist_mat:  A n1 by n2 matrix, with (i,j)^th entry being the 
  %                        angular distance between X1(i,:) and X2(j,:)
  %            .dist_type: 'angular_distance'
  %                                                                                                              
  % Assumptions: Assume we can compute and store this n1 by n2 matrix in memory
  % Assumptions: No observations are zeros 

  % Author: KK

  % See derivations.pdf for more info
  
  dist_struct.dist_mat = acos((X1.mat * X2.mat') ./ sqrt(repmat(sum((X1.mat).^2,2),1,X2.num_obs) .* repmat(sum((X2.mat).^2,2),1,X1.num_obs)'));
  dist_struct.dist_type = 'angular_distance';


end
      
  