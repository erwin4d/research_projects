function [estimated_dist_mat] = estimate_pairwise_ordinary_IP_for_random_projections(V_struct)

  % V_struct: A structure with at least two fields, being
  %           .mat: A n by k matrix, given by X_mat * R_mat in previous functions;
  %           .scaling_factor: Same scaling factor as R_struct.
  
  
  % Output: estimated_dist_mat
  %         This is a n by n upper triangular matrix, where the (i,j)^th term is the inner product
  %         between the ith row and jth column of X (see function "compute_V_for_random_projection")

 
  % Author: KK

  % See derivations.pdf for more info

  dist_mat = get_pairwise_distances_big(V_struct, V_struct, 'dot_product');
  estimated_dist_mat = triu(dist_mat.dist_mat / V_struct.scaling_factor,1);
  
 
end
      
  