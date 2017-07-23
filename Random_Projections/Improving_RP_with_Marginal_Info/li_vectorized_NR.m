function [ IP_vals ] = li_vectorized_NR(ests)

  % This finds the inner product values for Li's maximum likelihood.
  % Not using cardano function since there's always some small probability of getting
  % complex numbers

  % We vectorize newton raphson to make it fast to find the root.


  v1v2_mat = ests.small_v1v2;
  v1norm_mat = ests.small_v1norm;
  v2norm_mat = ests.small_v2norm;
  m1_mat = ones(ests.n1,ests.n2);
  m2_mat = ones(ests.n1,ests.n2);
  %m1m2_mat = ones(ests.n1,ests.n2);

  TOL = 1e-8;          % Initialize tolerance
  max_iter = 100;      % and max iterations
  iter = 0;            % and starting number of iter

    

  tot_size = prod(size(v1v2_mat));
  orig_size = size(v1v2_mat);

  v1v2_mat = reshape(v1v2_mat, 1, tot_size);
  v1norm_mat = reshape(v1norm_mat, 1, tot_size);
  v2norm_mat = reshape(v2norm_mat, 1, tot_size);

  m1_mat = reshape(m1_mat, 1, tot_size);
  m2_mat = reshape(m2_mat,1,  tot_size);

  mimj_mat = m1_mat .* m2_mat;

  % Now to do vectorized NR 
  % Note that the update step features a denominator ; thus potentially
  % could have denominator to be 0 if first derivative is zero

  % Init starting values (use initial estimated IP as start point)
  
  a_now = v1v2_mat;
  len_a = length(v1v2_mat);
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
    [ fx, dfx ] = local_NR_for_li( a_now(idx_to_go), v1v2_mat(idx_to_go), mimj_mat(idx_to_go), m1_mat(idx_to_go), v2norm_mat(idx_to_go), m2_mat(idx_to_go), v1norm_mat(idx_to_go) );       

    a_now(idx_to_go) = a_now(idx_to_go) - fx./dfx;

    % check which points to still iterate on    
    idx_to_go = idx_to_go(abs(a_now(idx_to_go) - a_prev(idx_to_go)) > TOL);
    is_term = length(idx_to_go);

  end

  % fix this in case we don't converge, replace
  a_now(idx_to_go) = v1v2_mat(idx_to_go);
  

  IP_vals = reshape(a_now, orig_size);







end


function [ fx, dfx ] = local_NR_for_li( a_mat, v1v2_mat, m1m2_mat, m1_mat, v2norm_mat, m2_mat, v1norm_mat )


  a3coef = 1;
  a2coef = -v1v2_mat;
  a1coef = - m1m2_mat + m1_mat .* v2norm_mat + m2_mat .* v1norm_mat;
  a0coef = - m1m2_mat .* v1v2_mat;

  fx = a3coef * a_mat.^3 + a2coef .* a_mat.^2  + a_mat .* a1coef + a0coef;
  dfx = 3 * a3coef * a_mat.^2 + 2 * (a_mat .* a2coef) +a1coef;

end
