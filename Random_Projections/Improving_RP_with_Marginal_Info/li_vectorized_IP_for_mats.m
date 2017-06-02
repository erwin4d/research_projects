function [ fx, dfx ] = li_vectorized_IP_for_mats( a_mat, v_IP_mat, mimj_mat, mi_mat, mj_mat, norm_vi_mat, norm_vj_mat )

  % This computes a vector of fx and first derivatives for
  % Li's MLE update to pass into newton raphson

  % a^3 - a^2 ( < v_i,  v_j >) + a (-m_im_j + m_i \|v_j\|_2^2 + m_j \|v_i\|_2^2) - m_im_j <v_i, v_j> = 0
  
  % See self_notes.pdf for more info

  % The goal is to compute the inner products of
  % v_i to all other v_js,  i \neq j at once (hence vectorized NR)

  
  
  % All are matrices
  
  fx = a_mat.^3 - (a_mat.^2 .* v_IP_mat) + a_mat .* ( - mimj_mat + mi_mat .* norm_vj_mat + mj_mat .* norm_vi_mat ) - mimj_mat .* v_IP_mat;
  dfx = 3 * a_mat.^2 - 2 * (a_mat .* v_IP_mat) + ( - mimj_mat + mi_mat .* norm_vj_mat + mj_mat .* norm_vi_mat );

end

