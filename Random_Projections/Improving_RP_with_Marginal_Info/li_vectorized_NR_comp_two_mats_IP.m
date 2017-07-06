function [ IP_vals ] = li_vectorized_NR_comp_two_mats_IP( vi_mat, vj_mat, m1_vec, m2_vec)

  % Given X1, X2 with same number of rows,
  % compute inner product between X1(j,:), X2(j,:)
  
  TOL = 1e-8;          % Initialize tolerance
  max_iter = 100;      % and max iterations
  iter = 0;            % and starting number of iter

  % Vectorized NR (given nrows) to compute MLE for Li's IP

  % Want to find pairwise inner product of <v_i1 v_j1>, <v_i2, v_j2>, ...
  
  % Thus, need to do some precomputations
  [ ip_vals, v1_vals, v2_vals] = run_RPCV_IP_task_seven_helper(vi_mat, vj_mat);

  mimj_vec = m1_vec .* m2_vec;

  % Now to do vectorized NR 
  % Note that the update step features a denominator ; thus potentially
  % could have denominator to be 0 if first derivative is zero

  % Init starting values (use initial estimated IP as start point)
  a_now = ip_vals;
  len_a = length(ip_vals);
  a_prev = zeros(len_a,1);

  % Terminate also when no more elements to do NR over 
  is_term = len_a;
  
  % Check number of idxes to go ; we stop iterating an element when TOL is met
  idx_to_go = 1:len_a;

  while is_term > 0 && iter < max_iter
    iter = iter + 1;
    
    % Update the indexes where we need to continue doing NR
    a_prev(idx_to_go) = a_now(idx_to_go);

    % Update steps
    [ fx, dfx ] = li_vectorized_IP_mle_two_vecs_fn( a_now(idx_to_go), ip_vals(idx_to_go), mimj_vec(idx_to_go), m1_vec(idx_to_go), v2_vals(idx_to_go), m2_vec(idx_to_go), v1_vals(idx_to_go) );       

    a_now(idx_to_go) = a_now(idx_to_go) - fx./dfx;

    % check which points to still iterate on    
    idx_to_go = idx_to_go(abs(a_now(idx_to_go) - a_prev(idx_to_go)) > TOL);
    is_term = length(idx_to_go);
  end
  

  IP_vals = a_now;


end

