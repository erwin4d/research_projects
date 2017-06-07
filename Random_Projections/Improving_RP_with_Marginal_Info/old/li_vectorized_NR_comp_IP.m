function [ IP_vals ] = li_vectorized_NR_comp_IP( vi_vec, vj_mat, mi, mj_vec, varargin)
  
  p = inputParser;  
  p.addRequired('vi_vec',@(x) true);
  p.addRequired('vj_mat',@(x) true);
  p.addRequired('mi',@(x) true);
  p.addRequired('mj_vec',@(x) true);
  p.addOptional('option', 'none', @(x) any(strcmp(x,{'normal', 'binary', 'SB', 'SRHT'})));
  p.addOptional('opt_para', -1, @(x) true);
  p.parse(vi_vec, vj_mat, mi, mj_vec, varargin{:});
  inputs = p.Results;  


  TOL = 1e-8;          % Initialize tolerance
  max_iter = 100;      % and max iterations
  iter = 0;            % and starting number of iter

  % Vectorized NR to compute MLE for Li's IP

  % Goal is given a vector vi_vec from V
  % and some matrix vj_mat 

  % Want to find pairwise inner product of <v_i, v_j1>, <v_i, v_j2>, ...
  
  % mi : scalar norm of xi
  % mj : vector norm of xjs

  % Thus, need to do some precomputations

  v_IP_vec = (vj_mat * vi_vec') ./ size(vj_mat,2); 
  len_a = size(v_IP_vec, 1);

  if strcmp(inputs.option, 'SB')
    v_IP_vec = v_IP_vec .* inputs.opt_para;
  end

  mimj_vec = mi * mj_vec;
  norm_vi = compute_generic_all_norm( vi_vec,  true, 'option', inputs.option, 'opt_para', inputs.opt_para, 'is_sim', false);
  norm_vj_vec = compute_generic_all_norm( vj_mat,  true, 'option', inputs.option, 'opt_para', inputs.opt_para, 'is_sim', false);


  % Now to do vectorized NR 
  % Note that the update step features a denominator ; thus potentially
  % could have denominator to be 0 if first derivative is zero

  % Init starting values (use initial estimated IP as start point)
  a_now = v_IP_vec;
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
    [ fx, dfx ] = li_vectorized_IP_mle_fn( a_now(idx_to_go), v_IP_vec(idx_to_go), mimj_vec(idx_to_go), mi, norm_vj_vec(idx_to_go), mj_vec(idx_to_go), norm_vi );       

    a_now(idx_to_go) = a_now(idx_to_go) - fx./dfx;

    % check which points to still iterate on    
    idx_to_go = idx_to_go(abs(a_now(idx_to_go) - a_prev(idx_to_go)) > TOL);
    is_term = length(idx_to_go);
  end
  

  IP_vals = a_now;


end

