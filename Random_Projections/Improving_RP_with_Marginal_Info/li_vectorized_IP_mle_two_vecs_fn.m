function [ fx, dfx ] = li_vectorized_IP_mle_two_vecs_fn( a_vec, v_IP_vec, mimj_vec, mi_vec, norm_vj_vec, mj_vec, norm_vi_vec )

  % This computes a vector of fx and first derivatives for
  % Li's MLE update to pass into newton raphson

  % a^3 - a^2 ( < v_i,  v_j >) + a (-m_im_j + m_i \|v_j\|_2^2 + m_j \|v_i\|_2^2) - m_im_j <v_i, v_j> = 0
  
  % See self_notes.pdf for more info

  % The goal is to compute the inner products of
  % v_i to all other v_js,  i \neq j at once (hence vectorized NR)

  
  
  % All vectors are p by 1

  % a_vec: Vector of guesses
  % v_IP_vec : Vector of inner products ( <v_i, v_j>)
  % mimj_vec: Vector of product of norms 
  % mi_vec : vector
  % norm_vj_vec : vector
  % mj_vec : vector
  % norm_vi_vec: vector

  fx = a_vec.^3 - (a_vec.^2 .* v_IP_vec) + a_vec .* ( - mimj_vec + mi_vec.* norm_vj_vec + mj_vec .* norm_vi_vec ) - mimj_vec .* v_IP_vec;
  dfx = 3 * a_vec.^2 - 2 * (a_vec .* v_IP_vec) + ( - mimj_vec + mi_vec .* norm_vj_vec + mj_vec .* norm_vi_vec );

end

