function [dist_struct] = get_pairwise_squared_euclidean_distance(X1, X2)

  % X1: n1 by p matrix of n1 observations and p parameters 
  % X2: n2 by p matrix of n2 observations and p parameters

  % dist_struct: Outputs a structure with two fields.
  %            .dist_mat:  A n1 by n2 matrix, with (i,j)^th entry being the 
  %                        squared Euclidean distance between X1(i,:) and X2(j,:)
  %            .dist_type: 'squared_Euclidean_distance'
  %                                                                                                              
  % Assumptions: Assume we can compute and store this n1 by n2 matrix in memory
  
  % Author: KK

  % See derivations.pdf for more info
  
  n1 = size(X1,1);
  n2 = size(X2,1);
  
  dist_struct.dist_mat = repmat(sum(X1.^2,2),1,n2) +  repmat(sum(X2.^2,2),1,n1)' -2*(X1 * X2');
  dist_struct.dist_type = 'squared_Euclidean_distance';


end
      
  