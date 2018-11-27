function [dist_struct] = get_pairwise_euclidean_distance(X1, X2)

  % X1, X2:A structure with at least two fields, being
  %           .mat: A n by p matrix with n observations and p features
  %           .num_obs: Number of observations
  %           

  % dist_struct: Outputs a structure with two fields.
  %            .dist_mat:  A n1 by n2 matrix, with (i,j)^th entry being the 
  %                        Euclidean distance between X1(i,:) and X2(j,:)
  %            .dist_type: 'Euclidean_distance'
  %                                                                                                              
  % Assumptions: Assume we can compute and store this n1 by n2 matrix in memory
  
  % Author: KK

  % See derivations.pdf for more info
  
  dist_struct = get_pairwise_squared_euclidean_distance(X1, X2);
  dist_struct.dist_mat = sqrt(dist_struct.dist_mat);
  dist_struct.dist_type = 'Euclidean_distance';


end
      
  