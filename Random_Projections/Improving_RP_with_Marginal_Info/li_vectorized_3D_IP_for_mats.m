function [ fx, dfx ] = li_vectorized_3D_IP_for_mats( a_mat, a1a3_mat, a2a3_mat, v_IP_mat , m1_mat, m2_mat, m3_mat, norm_v1_mat, norm_v2_mat, norm_v3_mat, v1v3_mat, v2v3_mat )

  % This computes a vector of fx and first derivatives for
  % Li's MLE update to pass into newton raphson

  % a^3 - a^2 ( < v_i,  v_j >) + a (-m_im_j + m_i \|v_j\|_2^2 + m_j \|v_i\|_2^2) - m_im_j <v_i, v_j> = 0
  
  % See self_notes.pdf for more info

  % The goal is to compute the inner products of
  % v_i to all other v_js,  i \neq j at once (hence vectorized NR)

  a3coef = - 2;
  a2coef = 6 * a1a3_mat .* a2a3_mat + 2* v_IP_mat + 2* a1a3_mat .* a2a3_mat .* norm_v3_mat  - 2* a2a3_mat .* v1v3_mat - 2* a1a3_mat .* v2v3_mat;

  a1coef = 2 - 2 * a1a3_mat.^2 - 2 * a2a3_mat.^2 - 4* a1a3_mat.^2 .* a2a3_mat.^2 - 2 * norm_v1_mat + 2 * a2a3_mat.^2 .* norm_v1_mat - 4 * a1a3_mat .* a2a3_mat .* v_IP_mat - 2 * norm_v2_mat + 2 * a1a3_mat.^2 .* norm_v2_mat + 4 * a1a3_mat .* v1v3_mat - 2* a2a3_mat.^2 .* norm_v3_mat.^2 + 4 * a2a3_mat .* v2v3_mat - 2 * a1a3_mat.^2 .* norm_v3_mat.^2;
  a0coef = - 2 *a1a3_mat .* a2a3_mat  + 2 *a1a3_mat.^3 .* a2a3_mat + 2 *a1a3_mat .* a2a3_mat.^3  + 2 * a1a3_mat .* a2a3_mat .* norm_v1_mat  - 2 * a1a3_mat .* a2a3_mat.^3 .* norm_v1_mat + 2 * v_IP_mat - 2 * a1a3_mat.^2 .* v_IP_mat  - 2 * a2a3_mat.^2 .* v_IP_mat + 4 * a1a3_mat.^2 .* a2a3_mat.^2 .* v_IP_mat  + 2 * a1a3_mat .* a2a3_mat .* norm_v2_mat -  2 * a1a3_mat.^3 .* a2a3_mat .* norm_v2_mat  - 2 * a2a3_mat .* v1v3_mat -  2 * a1a3_mat.^2 .* a2a3_mat .* v1v3_mat + 2 * a2a3_mat.^3 .* v1v3_mat - 2 * a1a3_mat .* v2v3_mat + 2 * a1a3_mat.^3 .* v2v3_mat  - 2 * a1a3_mat .* a2a3_mat.^2 .* v2v3_mat  + 2 * a1a3_mat .* a2a3_mat .* norm_v3_mat;
 
  % All are matrices
  
  fx = a3coef * a_mat.^3 + a2coef .* a_mat.^2  + a_mat .* a1coef + a0coef;
  dfx = 3 * a3coef * a_mat.^2 + 2 * (a_mat .* a2coef) +a1coef;

end





