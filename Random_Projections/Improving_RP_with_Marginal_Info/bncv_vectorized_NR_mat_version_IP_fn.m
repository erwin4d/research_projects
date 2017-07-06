function [ fx, dfx ] = bncv_vectorized_NR_mat_version_IP_fn( a_mat , ip_mat, mimj_mat, m1_mat, vj_norm_mat, m2_mat, vi_norm_mat )

  % This computes a vector of fx and first derivatives for
  % Li's MLE update to pass into newton raphson

  % a^3 - a^2 ( < v_i,  v_j >) + a (-m_im_j + m_i \|v_j\|_2^2 + m_j \|v_i\|_2^2) - m_im_j <v_i, v_j> = 0
  
  % See self_notes.pdf for more info

  % The goal is to compute the inner products of
  % v_i to all other v_js,  i \neq j at once (hence vectorized NR)

  a3coef = 2;
  a2coef = -2*ip_mat;
  a1coef =  (m1_mat.^2 .* vi_norm_mat.^2 + m2_mat.^2 .* vj_norm_mat.^2 + mimj_mat.*(-2 + vi_norm_mat.^2 + vj_norm_mat.^2));
  a0coef = -(m1_mat.^2 + m2_mat.^2) .*ip_mat;
  
  fx = a3coef * a_mat.^3 + a2coef .* a_mat.^2  + a_mat .* a1coef + a0coef;
  dfx = 3 * a3coef * a_mat.^2 + 2 * (a_mat .* a2coef) +a1coef;

end





