function [R_struct] = generate_normal_R(X_struct, k)

  % X_struct: A structure with at least two fields, being
  %           .X_mat: A n by p matrix with n observations and p features
  %           .num_p: Number of features
  
  %       k:  The dimension to project xvecs to

  % R_struct: Outputs a structure with two fields.
  %            .R_mat:  A p by k matrix, where each entries are iid N(0,1)
  %            .scaling_factor: In order to estimate dot product or Euclidean distance from V_mat, 
  %                             we usually compute V = 1/sqrt(k) XR, and then find the inner product
  %                             or Euclidean distance between rows of V. 
  %                             Since computing 1/sqrt(k) and multiplying it by every entry in XR
  %                             is costly, we could instead compute the inner product or Euclidean
  %                             distance between rows of XR, and then divide it by k
  %                             We set scaling_factor to be k.
  %                                                                                                              
 
  % Author: KK

  % See derivations.pdf for more info
  
  R_struct.R_mat = normrnd(0,1,X_struct.num_p,k);
  R_struct.scaling_factor = k;


end
      
  