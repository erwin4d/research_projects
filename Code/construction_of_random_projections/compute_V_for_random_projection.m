function [V_struct] = compute_V_for_random_projection(X_struct, R_struct)

  % X_struct: A structure with at least two fields, being
  %           .mat: A n by p matrix with n observations and p features
  %           .num_p: Number of features
  
  % R_struct: A structure with at least two fields, being
  %           .R_mat:  A p by k matrix, where each entries are iid N(0,1)
  %           .scaling_factor: In order to estimate dot product or Euclidean distance from V_mat, 
  %                             we usually compute V = 1/sqrt(k) XR (or similar, based on the type
  %                             of random matrix). 
  %                             Since computing 1/sqrt(k) and multiplying it by every entry in XR
  %                             is costly, we could instead compute the inner product or Euclidean
  %                             distance between rows of XR, and then divide it by k
  %                             
  
  % The output is given by V_struct with three fields
  %           .mat: A n by k matrix, given by X_mat * R_mat;
  %           .scaling_factor: Same scaling factor as R_struct.
  %           .num_obs: n

  % Author: KK

  % See derivations.pdf for more info
  
  V_struct.mat = X_struct.mat * R_struct.R_mat;
  V_struct.scaling_factor = R_struct.scaling_factor;
  V_struct.num_obs = size(X_struct.mat,1);


end
      
  