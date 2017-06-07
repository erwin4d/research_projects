function [ ] = run_RPCV_simulations_demo(data_name, nsims, is_norm)
  
  NUM_TYPES_MATRICES = 5;
  % This demo cycles through 5 different types of random projection matrices
  % Projects down to k = 2:2:100

  % Load a dataset, look at the 0th, 10th, 20th, ...100th percentiles of either ED or IP
  % and..

  % If sim_type is ED, then with our 11 pairs of vectors, we

  % Compute ordinary estimates of ED  ------------------------------------Record This
  % Compute ordinary estimate of IP
  % Use Li's method to compute estimates of inner product
  % Use Li's method to estimate ED ; (x - y)^2 = x^2 + y^2 - 2xy -------- Record This
  % Compute empirical alpha (CV) with given estimates to estimate ED ---- Record This
  % Compute theoretical alpha with ordinary IP estimate to estimate ED -- Record This
  % Compute theoretical alpha with Li's estimates to estimate ED -------- Record This

  % If sim_type is IP, then with our 11 pairs of vectors, we

  % Compute ordinary estimates of IP  ----------------------------------- Record This
  % Use Li's method to compute estimates of inner product --------------- Record This
  % Compute empirical alpha (CV) with given estimates to estimate IP ---- Record This
  % Compute theoretical alpha with ordinary IP estimate to estimate IP -- Record This
  % Compute theoretical alpha with Li's estimates to estimate IP -------- Record This

  % Initialize kvec to always be 2:2:100 ; could change here
  kvec = [2:2:100];
  num_eigs = 2;
  % Load in dataset percentiles

  [ EDPair1, EDPair2, sqnormEDPair1, sqnormEDPair2] = load_datasets_for_rpcv_sims(data_name, 'ED', is_norm);
  [ IPPair1, IPPair2, sqnormIPPair1, sqnormIPPair2] = load_datasets_for_rpcv_sims(data_name, 'IP', is_norm);

  num_para = size(EDPair1, 2);
  % look at top two eigenvectors only (could potentially do more, but stop at 2)

  [eig_vecs] = get_eigs_datasets_for_rpcv_sims(data_name, num_eigs);
  [rand_vecs] = get_rand_vecs_for_rpcv_sims(num_para);

  % Compute exact vals (either ED or IP)
  true_ED_vals = sqrt(sum((EDPair1 - EDPair2).^2,2));
  true_IP_vals = sum( IPPair1 .* IPPair2,2);
  
  [EDPair_for_ED_rpcv_comp_eigvec_pair1, EDPair_for_ED_rpcv_comp_eigvec_pair2] = get_edip_pairs_for_rpcv_sims(eig_vecs, EDPair1, EDPair2, 'ED');

  [EDPair_for_IP_rpcv_comp_eigvec_pair1, EDPair_for_IP_rpcv_comp_eigvec_pair2] = get_edip_pairs_for_rpcv_sims(eig_vecs, EDPair1, EDPair2, 'IP');


  [IPPair_for_ED_rpcv_comp_eigvec_pair1, IPPair_for_ED_rpcv_comp_eigvec_pair2] = get_edip_pairs_for_rpcv_sims(eig_vecs, IPPair1, IPPair2, 'ED');

  [IPPair_for_IP_rpcv_comp_eigvec_pair1, IPPair_for_IP_rpcv_comp_eigvec_pair2] = get_edip_pairs_for_rpcv_sims(eig_vecs, IPPair1, IPPair2, 'IP');


 [EDPair_for_ED_rpcv_comp_randvec_pair1, EDPair_for_ED_rpcv_comp_randvec_pair2] = get_edip_pairs_for_rpcv_sims(rand_vecs, EDPair1, EDPair2, 'ED');

  [EDPair_for_IP_rpcv_comp_randvec_pair1, EDPair_for_IP_rpcv_comp_randvec_pair2] = get_edip_pairs_for_rpcv_sims(rand_vecs, EDPair1, EDPair2, 'IP');


  [IPPair_for_ED_rpcv_comp_randvec_pair1, IPPair_for_ED_rpcv_comp_randvec_pair2] = get_edip_pairs_for_rpcv_sims(rand_vecs, IPPair1, IPPair2, 'ED');

  [IPPair_for_IP_rpcv_comp_randvec_pair1, IPPair_for_IP_rpcv_comp_randvec_pair2] = get_edip_pairs_for_rpcv_sims(rand_vecs, IPPair1, IPPair2, 'IP');


  
  % Let's start by creating ten 4 dim matrices to store our estimates (normal RPCV)

  err_mat_ED_ord = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); % 5 different types of RP matrices
  err_mat_ED_li = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_cv_emp = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_cv_thr_ord = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES);
  err_mat_ED_cv_thr_li = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES);

  err_mat_IP_ord = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); % 5 different types of RP matrices
  err_mat_IP_li = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_cv_emp = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_cv_thr_ord = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_cv_thr_li = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 


  % Multiple CV (empirical)

  err_mat_ED_mult_cv_emp_edtype_one_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_emp_iptype_one_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_emp_edtype_two_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_emp_iptype_two_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 

  err_mat_IP_mult_cv_emp_edtype_one_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_emp_iptype_one_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_emp_edtype_two_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_emp_iptype_two_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 

  err_mat_ED_mult_cv_emp_edtype_one_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_emp_iptype_one_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_emp_edtype_two_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_emp_iptype_two_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 

  err_mat_IP_mult_cv_emp_edtype_one_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_emp_iptype_one_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_emp_edtype_two_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_emp_iptype_two_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 


  % Multiple CV (using estimated IP)

  err_mat_ED_mult_cv_thr_edtype_one_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_thr_iptype_one_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_thr_edtype_two_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_thr_iptype_two_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 

  err_mat_IP_mult_cv_thr_edtype_one_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_thr_iptype_one_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_thr_edtype_two_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_thr_iptype_two_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 

  err_mat_ED_mult_cv_thr_edtype_one_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_thr_iptype_one_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_thr_edtype_two_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_thr_iptype_two_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 

  err_mat_IP_mult_cv_thr_edtype_one_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_thr_iptype_one_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_thr_edtype_two_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_thr_iptype_two_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 

  % Multiple CV (using li's IP)

  err_mat_ED_mult_cv_lis_edtype_one_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_lis_iptype_one_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_lis_edtype_two_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_lis_iptype_two_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 

  err_mat_IP_mult_cv_lis_edtype_one_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_lis_iptype_one_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_lis_edtype_two_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_lis_iptype_two_mult_evec = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 

  err_mat_ED_mult_cv_lis_edtype_one_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_lis_iptype_one_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_lis_edtype_two_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_ED_mult_cv_lis_iptype_two_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 

  err_mat_IP_mult_cv_lis_edtype_one_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_lis_iptype_one_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_lis_edtype_two_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 
  err_mat_IP_mult_cv_lis_iptype_two_mult_rand = zeros(nsims, 11, length(kvec), NUM_TYPES_MATRICES); 


  k_max = max(kvec);
  Had = createHad( num_para ); % Create Hadamard matrix (not going to recursively multiply matrices later)

  % Start iteration here
  for iters = 1:nsims
    [num2str(iters), ' ... ', data_name]   

    % Create our results V.. 
    [V_EDPair1, V_EDPair2, V_IPPair1, V_IPPair2, V_eig_vecs, V_rand_vecs] = create_rpcv_types_of_V( EDPair1, EDPair2, IPPair1, IPPair2, eig_vecs, rand_vecs, num_para, k_max, NUM_TYPES_MATRICES, Had);
    % so far so good
    for kvals = 1:length(kvec);
      k = kvec(kvals);
      for types = 1:NUM_TYPES_MATRICES;
        % Let's do the computation so
        small_V_EDPair1 = V_EDPair1(:, 1:k, types);
        small_V_EDPair2 = V_EDPair2(:, 1:k, types);
        small_V_IPPair1 = V_IPPair1(:, 1:k, types);
        small_V_IPPair2 = V_IPPair2(:, 1:k, types);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute ordinary estimates of ED with EDPairs
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        err_mat_ED_ord(iters,:,kvals,types) = run_RPCV_ED_task_one_sim(small_V_EDPair1, small_V_EDPair2, types);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute ordinary estimates of IP with ED Pairs   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Just need to compute this as a vector - no need to save
        ord_IP_est_for_ED = run_RPCV_IP_task_six_sim(small_V_EDPair1, small_V_EDPair2, types);
      
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Use Li's method to compute IP of ED Pairs  
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Just need to compute this as a vector - no need to save
        li_est_IP_for_ED = run_RPCV_IP_task_seven_sim(small_V_EDPair1, small_V_EDPair2, sqnormEDPair1, sqnormEDPair2, types);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Use Li's estimate of IP to compute ED (this should be bad - sanity check)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        err_mat_ED_li(iters,:,kvals,types) = run_RPCV_ED_task_two_sim(sqnormEDPair1, sqnormEDPair2, li_est_IP_for_ED);


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Empirical Control Variate of ED pairs 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        err_mat_ED_cv_emp(iters,:,kvals,types) = run_RPCV_ED_task_three_sim(small_V_EDPair1, small_V_EDPair2, sqnormEDPair1, sqnormEDPair2, types);


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Theoretical Control Variate of ED pairs given naive est of IP
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        err_mat_ED_cv_thr_ord(iters,:,kvals,types) = run_RPCV_ED_task_four_sim(small_V_EDPair1, small_V_EDPair2, sqnormEDPair1, sqnormEDPair2, ord_IP_est_for_ED, types);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Theoretical Control Variate of ED pairs given li est of IP
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       err_mat_ED_cv_thr_li(iters,:,kvals,types) = run_RPCV_ED_task_four_sim(small_V_EDPair1, small_V_EDPair2, sqnormEDPair1, sqnormEDPair2, li_est_IP_for_ED, types);



        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute ordinary estimates of IP with IP Pairs   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        err_mat_IP_ord(iters,:,kvals,types) = run_RPCV_IP_task_six_sim(small_V_IPPair1, small_V_IPPair2, types);


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Use Li's method to compute IP of ED Pairs   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        err_mat_IP_li(iters,:,kvals,types) = run_RPCV_IP_task_seven_sim(small_V_IPPair1, small_V_IPPair2, sqnormIPPair1, sqnormIPPair2, types);


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Empirical Control Variate of IP pairs 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        err_mat_IP_cv_emp(iters,:,kvals,types) = run_RPCV_IP_task_eight_sim(small_V_IPPair1, small_V_IPPair2, sqnormIPPair1, sqnormIPPair2, types);


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Theoretical Control Variate of IP pairs give naive est of IP
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        err_mat_IP_cv_thr_ord(iters,:,kvals,types) = run_RPCV_IP_task_nine_sim(small_V_IPPair1, small_V_IPPair2, sqnormIPPair1, sqnormIPPair2, err_mat_IP_ord(iters,:,kvals,types)', types);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Theoretical Control Variate of IP pairs give li est of IP
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        err_mat_IP_cv_thr_ord(iters,:,kvals,types) = run_RPCV_IP_task_nine_sim(small_V_IPPair1, small_V_IPPair2, sqnormIPPair1, sqnormIPPair2, err_mat_IP_li(iters,:,kvals,types)', types);
      end
    end
  end

  % Compute MSE, Var, Bias and save
  % Ten Tasks
  % First Task: 
  compute_mse_var_bias_for_rpcv_sim(data_name, err_mat_ED_ord, true_ED_vals, is_norm, 'ord_ED');
  compute_mse_var_bias_for_rpcv_sim(data_name, err_mat_ED_li, true_ED_vals, is_norm, 'ord_ED_using_bin_exp');
  compute_mse_var_bias_for_rpcv_sim(data_name, err_mat_ED_cv_emp, true_ED_vals, is_norm, 'empirical_CV_ED');
  compute_mse_var_bias_for_rpcv_sim(data_name, err_mat_ED_cv_thr_ord, true_ED_vals, is_norm, 'theory_CV_via_naive_est_ED');
  compute_mse_var_bias_for_rpcv_sim(data_name, err_mat_ED_cv_thr_li, true_ED_vals, is_norm, 'theory_CV_via_li_est_ED');

  compute_mse_var_bias_for_rpcv_sim(data_name, err_mat_IP_ord, true_IP_vals, is_norm, 'ord_IP');
  compute_mse_var_bias_for_rpcv_sim(data_name, err_mat_IP_li, true_IP_vals, is_norm, 'li_IP');
  compute_mse_var_bias_for_rpcv_sim(data_name, err_mat_IP_cv_emp, true_IP_vals, is_norm, 'empirical_CV_IP');
  compute_mse_var_bias_for_rpcv_sim(data_name, err_mat_IP_cv_thr_ord, true_IP_vals, is_norm, 'theory_CV_via_naive_est_IP');
  compute_mse_var_bias_for_rpcv_sim(data_name, err_mat_IP_cv_thr_li, true_IP_vals, is_norm, 'theory_CV_via_li_est_IP');



end


