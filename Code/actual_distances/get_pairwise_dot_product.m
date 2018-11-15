function [dist_struct] = get_pairwise_dot_product(X1, X2)

  % X1: n1 by p matrix of n1 observations and p parameters 
  % X2: n2 by p matrix of n2 observations and p parameters

  % dist_struct: Outputs a structure with two fields.
  %            .dist_mat:  A n1 by n2 matrix, with (i,j)^th entry being the 
  %                        dot product between X1(i,:) and X2(j,:)
  %            .dist_type: 'dot_product'
  %                                                                                                              
  % Assumptions: Assume we can compute and store this n1 by n2 matrix in memory
  
  % Author: KK

  % See derivations.pdf for more info
    
  dist_struct.dist_mat = X1 * X2';
  dist_struct.dist_type = 'dot_product';


end
      
  