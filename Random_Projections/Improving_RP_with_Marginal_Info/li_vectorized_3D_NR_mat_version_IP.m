function [ IP_vals ] = li_vectorized_3D_NR_mat_version_IP( ip_mat, vi_norm_mat, vj_norm_mat, m1_mat, m2_mat, m3_mat, a1a3_mat, a2a3_mat, norm_v3_mat, v1v3_mat, v2v3_mat)

  % Given X1, X2 with same number of rows,
  % compute inner product between X1(j,:), X2(j,:)
  
  TOL = 1e-8;          % Initialize tolerance
  max_iter = 100;      % and max iterations
  iter = 0;            % and starting number of iter

  % Vectorized NR (given mat) to compute MLE for Li's IP


  % Want to find pairwise inner product of <v_i1 v_j1>, <v_i2, v_j2>, ...
  
  % Thus, need to do some precomputations
  
  % Want to unroll mats
  
  tot_size = prod(size(ip_mat));
  orig_size = size(ip_mat);

  ip_mat = reshape(ip_mat, 1, tot_size);
  vi_norm_mat = reshape(vi_norm_mat, 1, tot_size);
  vj_norm_mat = reshape(vj_norm_mat, 1, tot_size);
  a1a3_mat = reshape(a1a3_mat, 1, tot_size);
  a2a3_mat = reshape(a2a3_mat, 1, tot_size);
  norm_v3_mat = reshape(norm_v3_mat, 1, tot_size);
  v1v3_mat = reshape(v1v3_mat, 1, tot_size);
  v2v3_mat = reshape(v2v3_mat, 1, tot_size);

  m1_mat = reshape(m1_mat, 1, tot_size);
  m2_mat = reshape(m2_mat,1,  tot_size);
  m3_mat = reshape(m3_mat,1,  tot_size);

  mimj_mat = m1_mat .* m2_mat;


  % Now to do vectorized NR 
  % Note that the update step features a denominator ; thus potentially
  % could have denominator to be 0 if first derivative is zero

  % Init starting values (use initial estimated IP as start point)
  
  a_now = ip_mat;
  len_a = length(ip_mat);
  a_prev = zeros(1, len_a);

  % Terminate also when no more elements to do NR over 
  is_term = len_a;
  
  % Check number of idxes to go ; we stop iterating an element when TOL is met
  idx_to_go = 1:len_a;

  while is_term > 0 && iter < max_iter

    iter = iter + 1;
    
    % Update the indexes where we need to continue doing NR
    a_prev(idx_to_go) = a_now(idx_to_go);

    % Update steps
    [ fx, dfx ] = li_vectorized_3D_IP_for_mats( a_now(idx_to_go), a1a3_mat(idx_to_go), a2a3_mat(idx_to_go), ip_mat(idx_to_go) , m1_mat(idx_to_go), m2_mat(idx_to_go), m3_mat(idx_to_go), vi_norm_mat(idx_to_go), vj_norm_mat(idx_to_go), norm_v3_mat(idx_to_go), v1v3_mat(idx_to_go), v2v3_mat(idx_to_go));       

    a_now(idx_to_go) = a_now(idx_to_go) - fx./dfx;

    % check which points to still iterate on    
    idx_to_go = idx_to_go(abs(a_now(idx_to_go) - a_prev(idx_to_go)) > TOL);
    is_term = length(idx_to_go);

  end

  % fix this in case we don't converge, replace
  a_now(idx_to_go) = ip_mat(idx_to_go);
  

  IP_vals = reshape(a_now, orig_size);


end

