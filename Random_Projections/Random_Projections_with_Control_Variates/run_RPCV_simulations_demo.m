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
  num_eig = 2;
  num_rand = 2;
  % Load in dataset percentiles

  [ EDInfo] = load_datasets_for_rpcv_sims(data_name, 'ED', is_norm);
  [ IPInfo] = load_datasets_for_rpcv_sims(data_name, 'IP', is_norm);

  num_para = size(EDInfo.pair1, 2);
  % look at top two eigenvectors only (could potentially do more, but stop at 2)

  [eig_vecs] = get_eigs_datasets_for_rpcv_sims(data_name, num_eig);
  [rand_vecs] = get_rand_vecs_for_rpcv_sims(num_para);

  % Compute exact vals (either ED or IP)
  true_ED_vals = sqrt(sum((EDInfo.pair1 - EDInfo.pair2).^2,2));
  true_IP_vals = sum( IPInfo.pair1 .* IPInfo.pair2,2);


  [EDInfo] = get_edip_pairs_for_rpcv_sims(eig_vecs, rand_vecs, EDInfo);
  [IPInfo] = get_edip_pairs_for_rpcv_sims(eig_vecs, rand_vecs, IPInfo);  
  
  % Let's start by creating ten 4 dim matrices to store our estimates (normal RPCV)

  num_quantiles = 11;

  [single_rpcv_struct] = create_single_rpcv_structure( zeros(nsims, num_quantiles, length(kvec), NUM_TYPES_MATRICES), true_ED_vals, true_IP_vals, data_name, nsims);

  % Multiple CV (empirical)

  empirical_mult_rpcv_struct = create_mult_rpcv_structure( zeros(nsims, num_quantiles, length(kvec), NUM_TYPES_MATRICES), true_ED_vals, true_IP_vals, data_name, nsims, 'empirical');


  % Multiple CV (using estimated IP)

  est_IP_mult_rpcv_struct = create_mult_rpcv_structure( zeros(nsims, num_quantiles, length(kvec), NUM_TYPES_MATRICES), true_ED_vals, true_IP_vals, data_name, nsims, 'IP_from_data');

  % Multiple CV (using li's IP)
  li_IP_mult_rpcv_struct = create_mult_rpcv_structure( zeros(nsims, num_quantiles, length(kvec), NUM_TYPES_MATRICES), true_ED_vals, true_IP_vals, data_name, nsims, 'IP_from_li');

  k_max = max(kvec);
  Had = createHad( num_para ); % Create Hadamard matrix (not going to recursively multiply matrices later)

  % Start iteration here
  for iters = 1:nsims
    [num2str(iters), ' ... ', data_name]   

    % Create our results V.. 
    [big_V] = create_rpcv_types_of_V( EDInfo, IPInfo, eig_vecs, rand_vecs, num_para, k_max, NUM_TYPES_MATRICES, Had);
    % so far so good
    for kvals = 1:length(kvec);
      k = kvec(kvals);
      for types = 1:NUM_TYPES_MATRICES;
        % Let's do the computation so
        [small_V_EDPair1, small_V_EDPair2, small_V_IPPair1,small_V_IPPair2, small_V_eigvec, small_V_randvec ] = rpcv_v_decoder(big_V, k, types, num_quantiles, num_eig, num_rand);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute ordinary estimates of ED with EDPairs
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        single_rpcv_struct.err_mat_ED_ord.store(iters,:,kvals,types) = compute_generic_ED_mats(small_V_EDPair1,small_V_EDPair2);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute ordinary estimates of IP with ED Pairs   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Just need to compute this as a vector - no need to save

        ord_IP_est_for_ED = compute_generic_IP_mats(small_V_EDPair1,small_V_EDPair2);
      
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Use Li's method to compute IP of ED Pairs  
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Just need to compute this as a vector - no need to save
        li_est_IP_for_ED = run_RPCV_IP_task_seven_sim(small_V_EDPair1, small_V_EDPair2, EDInfo.normPair1, EDInfo.normPair2);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Use Li's estimate of IP to compute ED (this should be bad - sanity check)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        single_rpcv_struct.err_mat_ED_li.store(iters,:,kvals,types) = run_RPCV_ED_task_two_sim(EDInfo.normPair1, EDInfo.normPair2, li_est_IP_for_ED);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Empirical Control Variate of ED pairs 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        single_rpcv_struct.err_mat_ED_cv_emp.store(iters,:,kvals,types) = run_RPCV_ED_task_three_sim(small_V_EDPair1, small_V_EDPair2, EDInfo.normPair1, EDInfo.normPair2, types);


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Theoretical Control Variate of ED pairs given naive est of IP
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        single_rpcv_struct.err_mat_ED_cv_thr_ord.store(iters,:,kvals,types) = run_RPCV_ED_task_four_sim(small_V_EDPair1, small_V_EDPair2, EDInfo.normPair1, EDInfo.normPair2, ord_IP_est_for_ED, types);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Theoretical Control Variate of ED pairs given li est of IP
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        single_rpcv_struct.err_mat_ED_cv_thr_li.store(iters,:,kvals,types) = run_RPCV_ED_task_four_sim(small_V_EDPair1, small_V_EDPair2, EDInfo.normPair1, EDInfo.normPair2, li_est_IP_for_ED, types);



        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute ordinary estimates of IP with IP Pairs   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        single_rpcv_struct.err_mat_IP_ord.store(iters,:,kvals,types) = compute_generic_IP_mats(small_V_IPPair1, small_V_IPPair2);


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Use Li's method to compute IP of ED Pairs   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        single_rpcv_struct.err_mat_IP_li.store(iters,:,kvals,types) = run_RPCV_IP_task_seven_sim(small_V_IPPair1, small_V_IPPair2, IPInfo.normPair1, IPInfo.normPair2);


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Empirical Control Variate of IP pairs 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        single_rpcv_struct.err_mat_IP_cv_emp.store(iters,:,kvals,types) = run_RPCV_IP_task_eight_sim(small_V_IPPair1, small_V_IPPair2, IPInfo.normPair1, IPInfo.normPair2, types);


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Theoretical Control Variate of IP pairs give naive est of IP
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        single_rpcv_struct.err_mat_IP_cv_thr_ord.store(iters,:,kvals,types) = run_RPCV_IP_task_nine_sim(small_V_IPPair1, small_V_IPPair2, IPInfo.normPair1, IPInfo.normPair2, single_rpcv_struct.err_mat_IP_ord.store(iters,:,kvals,types)', types);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Theoretical Control Variate of IP pairs give li est of IP
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        single_rpcv_struct.err_mat_IP_cv_thr_ord.store(iters,:,kvals,types) = run_RPCV_IP_task_nine_sim(small_V_IPPair1, small_V_IPPair2, IPInfo.normPair1, IPInfo.normPair2, single_rpcv_struct.err_mat_IP_li.store(iters,:,kvals,types)', types);


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Mult CV for ED, using ED CV
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        empirical_mult_rpcv_struct.one_evec_by_ED_for_ED.store(iters,:,kvals,types) = get_mult_emp_onevec(small_V_EDPair1, small_V_EDPair2, small_V_eigvec, EDInfo.eigvecs_ED_1, EDInfo.eigvecs_ED_2, types, 'ED-ish', 'est_ED');

        empirical_mult_rpcv_struct.one_rand_by_ED_for_ED.store(iters,:,kvals,types) = get_mult_emp_onevec(small_V_EDPair1, small_V_EDPair2, small_V_randvec, EDInfo.random_ED_1, EDInfo.random_ED_2, types, 'ED-ish', 'est_ED');        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Mult CV for ED, using IP CV
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        empirical_mult_rpcv_struct.one_evec_by_IP_for_ED.store(iters,:,kvals,types) = get_mult_emp_onevec(small_V_EDPair1, small_V_EDPair2, small_V_eigvec, EDInfo.eigvecs_IP_1, EDInfo.eigvecs_IP_2, types, 'IP-ish', 'est_ED');


        empirical_mult_rpcv_struct.one_rand_by_IP_for_ED.store(iters,:,kvals,types) = get_mult_emp_onevec(small_V_EDPair1, small_V_EDPair2, small_V_randvec, EDInfo.random_IP_1, EDInfo.random_IP_2, types,'IP-ish', 'est_ED');


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Mult CV for IP, using ED CV
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        empirical_mult_rpcv_struct.one_evec_by_ED_for_IP.store(iters,:,kvals,types) = get_mult_emp_onevec(small_V_IPPair1, small_V_IPPair2, small_V_eigvec, IPInfo.eigvecs_ED_1, IPInfo.eigvecs_ED_2, types, 'ED-ish', 'est_IP');

        empirical_mult_rpcv_struct.one_rand_by_ED_for_IP.store(iters,:,kvals,types) = get_mult_emp_onevec(small_V_IPPair1, small_V_IPPair2, small_V_randvec, IPInfo.random_ED_1, IPInfo.random_ED_2, types, 'ED-ish', 'est_IP');  

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Mult CV for IP, using IP CV
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        empirical_mult_rpcv_struct.one_evec_by_IP_for_IP.store(iters,:,kvals,types) = get_mult_emp_onevec(small_V_IPPair1, small_V_IPPair2, small_V_eigvec, IPInfo.eigvecs_IP_1, IPInfo.eigvecs_IP_2, types, 'IP-ish', 'est_IP');


        empirical_mult_rpcv_struct.one_rand_by_IP_for_IP.store(iters,:,kvals,types) = get_mult_emp_onevec(small_V_IPPair1, small_V_IPPair2, small_V_randvec, IPInfo.random_IP_1, IPInfo.random_IP_2, types,'IP-ish', 'est_IP');      
        

         

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Mult CV for ED, using ED CV
        %% Using IP from data and LI
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        est_IP_mult_rpcv_struct.one_evec_by_ED_for_ED.store(iters,:,kvals,types) =         get_mult_plugin_ip_onevec(small_V_EDPair1, small_V_EDPair2, small_V_eigvec, EDInfo.eigvecs_ED_1, EDInfo.eigvecs_ED_2, types, 'ED-ish', 'est_ED', EDInfo.eigvecs_IP_1, EDInfo.eigvecs_IP_2, ord_IP_est_for_ED);

        est_IP_mult_rpcv_struct.one_rand_by_ED_for_ED.store(iters,:,kvals,types) =         get_mult_plugin_ip_onevec(small_V_EDPair1, small_V_EDPair2, small_V_randvec, EDInfo.random_ED_1, EDInfo.random_ED_2, types, 'ED-ish', 'est_ED', EDInfo.random_IP_1, EDInfo.random_IP_2, ord_IP_est_for_ED);


        li_IP_mult_rpcv_struct.one_evec_by_ED_for_ED.store(iters,:,kvals,types) =         get_mult_plugin_ip_onevec(small_V_EDPair1, small_V_EDPair2, small_V_eigvec, EDInfo.eigvecs_ED_1, EDInfo.eigvecs_ED_2, types, 'ED-ish', 'est_ED', EDInfo.eigvecs_IP_1, EDInfo.eigvecs_IP_2, li_est_IP_for_ED);

        li_IP_mult_rpcv_struct.one_rand_by_ED_for_ED.store(iters,:,kvals,types) =         get_mult_plugin_ip_onevec(small_V_EDPair1, small_V_EDPair2, small_V_randvec, EDInfo.random_ED_1, EDInfo.random_ED_2, types, 'ED-ish', 'est_ED', EDInfo.random_IP_1, EDInfo.random_IP_2, li_est_IP_for_ED);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Mult CV for ED, using IP CV
        %% Using IP from data and LI
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        est_IP_mult_rpcv_struct.one_evec_by_IP_for_ED.store(iters,:,kvals,types) = get_mult_plugin_ip_onevec(small_V_EDPair1, small_V_EDPair2, small_V_eigvec, EDInfo.eigvecs_IP_1, EDInfo.eigvecs_IP_2, types, 'IP-ish', 'est_ED', EDInfo.eigvecs_IP_1, EDInfo.eigvecs_IP_2, ord_IP_est_for_ED);


        est_IP_mult_rpcv_struct.one_rand_by_IP_for_ED.store(iters,:,kvals,types) = get_mult_plugin_ip_onevec(small_V_EDPair1, small_V_EDPair2, small_V_randvec, EDInfo.random_IP_1, EDInfo.random_IP_2, types,'IP-ish', 'est_ED',EDInfo.random_IP_1, EDInfo.random_IP_2, ord_IP_est_for_ED);


        li_IP_mult_rpcv_struct.one_evec_by_IP_for_ED.store(iters,:,kvals,types) = get_mult_plugin_ip_onevec(small_V_EDPair1, small_V_EDPair2, small_V_eigvec, EDInfo.eigvecs_IP_1, EDInfo.eigvecs_IP_2, types, 'IP-ish', 'est_ED', EDInfo.eigvecs_IP_1, EDInfo.eigvecs_IP_2, li_est_IP_for_ED);


        li_IP_mult_rpcv_struct.one_rand_by_IP_for_ED.store(iters,:,kvals,types) = get_mult_plugin_ip_onevec(small_V_EDPair1, small_V_EDPair2, small_V_randvec, EDInfo.random_IP_1, EDInfo.random_IP_2, types,'IP-ish', 'est_ED',EDInfo.random_IP_1, EDInfo.random_IP_2, li_est_IP_for_ED);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Mult CV for IP, using ED CV
        %% Using IP from data and LI
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        est_IP_mult_rpcv_struct.one_evec_by_ED_for_IP.store(iters,:,kvals,types) = get_mult_plugin_ip_onevec(small_V_IPPair1, small_V_IPPair2, small_V_eigvec, IPInfo.eigvecs_ED_1, IPInfo.eigvecs_ED_2, types, 'ED-ish', 'est_IP', IPInfo.eigvecs_IP_1, IPInfo.eigvecs_IP_2, single_rpcv_struct.err_mat_IP_ord.store(iters,:,kvals,types)');

        est_IP_mult_rpcv_struct.one_rand_by_ED_for_IP.store(iters,:,kvals,types) = get_mult_plugin_ip_onevec(small_V_IPPair1, small_V_IPPair2, small_V_randvec, IPInfo.random_ED_1, IPInfo.random_ED_2, types, 'ED-ish', 'est_IP', IPInfo.random_IP_1, IPInfo.random_IP_2, single_rpcv_struct.err_mat_IP_ord.store(iters,:,kvals,types)');  

        li_IP_mult_rpcv_struct.one_evec_by_ED_for_IP.store(iters,:,kvals,types) = get_mult_plugin_ip_onevec(small_V_IPPair1, small_V_IPPair2, small_V_eigvec, IPInfo.eigvecs_ED_1, IPInfo.eigvecs_ED_2, types, 'ED-ish', 'est_IP', IPInfo.eigvecs_IP_1, IPInfo.eigvecs_IP_2, single_rpcv_struct.err_mat_IP_li.store(iters,:,kvals,types)');

        li_IP_mult_rpcv_struct.one_rand_by_ED_for_IP.store(iters,:,kvals,types) = get_mult_plugin_ip_onevec(small_V_IPPair1, small_V_IPPair2, small_V_randvec, IPInfo.random_ED_1, IPInfo.random_ED_2, types, 'ED-ish', 'est_IP', IPInfo.random_IP_1, IPInfo.random_IP_2, single_rpcv_struct.err_mat_IP_li.store(iters,:,kvals,types)');  

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Compute Mult CV for IP, using IP CV
        %% Using IP from data and LI
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        est_IP_mult_rpcv_struct.one_evec_by_IP_for_IP.store(iters,:,kvals,types) = get_mult_plugin_ip_onevec(small_V_IPPair1, small_V_IPPair2, small_V_eigvec, IPInfo.eigvecs_IP_1, IPInfo.eigvecs_IP_2, types, 'IP-ish', 'est_IP', IPInfo.eigvecs_IP_1, IPInfo.eigvecs_IP_2, single_rpcv_struct.err_mat_IP_ord.store(iters,:,kvals,types)');


        est_IP_mult_rpcv_struct.one_rand_by_IP_for_IP.store(iters,:,kvals,types) = get_mult_plugin_ip_onevec(small_V_IPPair1, small_V_IPPair2, small_V_randvec, IPInfo.random_IP_1, IPInfo.random_IP_2, types,'IP-ish', 'est_IP',IPInfo.random_IP_1, IPInfo.random_IP_2, single_rpcv_struct.err_mat_IP_ord.store(iters,:,kvals,types)');      

       li_IP_mult_rpcv_struct.one_evec_by_IP_for_IP.store(iters,:,kvals,types) = get_mult_plugin_ip_onevec(small_V_IPPair1, small_V_IPPair2, small_V_eigvec, IPInfo.eigvecs_IP_1, IPInfo.eigvecs_IP_2, types, 'IP-ish', 'est_IP', IPInfo.eigvecs_IP_1, IPInfo.eigvecs_IP_2, single_rpcv_struct.err_mat_IP_li.store(iters,:,kvals,types)');


        li_IP_mult_rpcv_struct.one_rand_by_IP_for_IP.store(iters,:,kvals,types) = get_mult_plugin_ip_onevec(small_V_IPPair1, small_V_IPPair2, small_V_randvec, IPInfo.random_IP_1, IPInfo.random_IP_2, types,'IP-ish', 'est_IP',IPInfo.random_IP_1, IPInfo.random_IP_2, single_rpcv_struct.err_mat_IP_li.store(iters,:,kvals,types)');      

      end
    end
  end

  % Compute MSE, Var, Bias and save
  % Ten Tasks
  % First Task: 
  compute_mse_var_bias_for_rpcv_sim(data_name, single_rpcv_struct.err_mat_ED_ord, true_ED_vals, is_norm, 'ord_ED');
  compute_mse_var_bias_for_rpcv_sim(data_name, single_rpcv_struct.err_mat_ED_li, true_ED_vals, is_norm, 'ord_ED_using_bin_exp');
  compute_mse_var_bias_for_rpcv_sim(data_name, single_rpcv_struct.err_mat_ED_cv_emp, true_ED_vals, is_norm, 'empirical_CV_ED');
  compute_mse_var_bias_for_rpcv_sim(data_name, single_rpcv_struct.err_mat_ED_cv_thr_ord, true_ED_vals, is_norm, 'theory_CV_via_naive_est_ED');
  compute_mse_var_bias_for_rpcv_sim(data_name, single_rpcv_struct.err_mat_ED_cv_thr_li, true_ED_vals, is_norm, 'theory_CV_via_li_est_ED');

  compute_mse_var_bias_for_rpcv_sim(data_name, single_rpcv_struct.err_mat_IP_ord, true_IP_vals, is_norm, 'ord_IP');
  compute_mse_var_bias_for_rpcv_sim(data_name, single_rpcv_struct.err_mat_IP_li, true_IP_vals, is_norm, 'li_IP');
  compute_mse_var_bias_for_rpcv_sim(data_name, single_rpcv_struct.err_mat_IP_cv_emp, true_IP_vals, is_norm, 'empirical_CV_IP');
  compute_mse_var_bias_for_rpcv_sim(data_name, single_rpcv_struct.err_mat_IP_cv_thr_ord, true_IP_vals, is_norm, 'theory_CV_via_naive_est_IP');
  compute_mse_var_bias_for_rpcv_sim(data_name, single_rpcv_struct.err_mat_IP_cv_thr_li, true_IP_vals, is_norm, 'theory_CV_via_li_est_IP');




  compute_mse_var_bias_for_rpcv_sim(data_name, empirical_mult_rpcv_struct.one_evec_by_ED_for_ED, true_ED_vals, is_norm, 'emp_one_evec_by_ED_for_ED');

  compute_mse_var_bias_for_rpcv_sim(data_name, empirical_mult_rpcv_struct.one_evec_by_IP_for_ED, true_ED_vals, is_norm, 'emp_one_evec_by_IP_for_ED');

  compute_mse_var_bias_for_rpcv_sim(data_name, empirical_mult_rpcv_struct.one_rand_by_ED_for_ED, true_ED_vals, is_norm, 'emp_one_rand_by_ED_for_ED');

  compute_mse_var_bias_for_rpcv_sim(data_name, empirical_mult_rpcv_struct.one_rand_by_IP_for_ED, true_ED_vals, is_norm, 'emp_one_rand_by_IP_for_ED');

  compute_mse_var_bias_for_rpcv_sim(data_name, empirical_mult_rpcv_struct.one_evec_by_ED_for_IP, true_IP_vals, is_norm, 'emp_one_evec_by_ED_for_IP');

  compute_mse_var_bias_for_rpcv_sim(data_name, empirical_mult_rpcv_struct.one_evec_by_IP_for_IP, true_IP_vals, is_norm, 'emp_one_evec_by_IP_for_IP');

  compute_mse_var_bias_for_rpcv_sim(data_name, empirical_mult_rpcv_struct.one_rand_by_ED_for_IP, true_IP_vals, is_norm, 'emp_one_rand_by_ED_for_IP');

  compute_mse_var_bias_for_rpcv_sim(data_name, empirical_mult_rpcv_struct.one_rand_by_IP_for_IP, true_IP_vals, is_norm, 'emp_one_rand_by_IP_for_IP');




  compute_mse_var_bias_for_rpcv_sim(data_name, est_IP_mult_rpcv_struct.one_evec_by_ED_for_ED, true_ED_vals, is_norm, 'subst_naive_ip_one_evec_by_ED_for_ED');

  compute_mse_var_bias_for_rpcv_sim(data_name, est_IP_mult_rpcv_struct.one_evec_by_IP_for_ED, true_ED_vals, is_norm, 'subst_naive_ip_one_evec_by_IP_for_ED');

  compute_mse_var_bias_for_rpcv_sim(data_name, est_IP_mult_rpcv_struct.one_rand_by_ED_for_ED, true_ED_vals, is_norm, 'subst_naive_ip_one_rand_by_ED_for_ED');

  compute_mse_var_bias_for_rpcv_sim(data_name, est_IP_mult_rpcv_struct.one_rand_by_IP_for_ED, true_ED_vals, is_norm, 'subst_naive_ip_one_rand_by_IP_for_ED');

  compute_mse_var_bias_for_rpcv_sim(data_name, est_IP_mult_rpcv_struct.one_evec_by_ED_for_IP, true_IP_vals, is_norm, 'subst_naive_ip_one_evec_by_ED_for_IP');

  compute_mse_var_bias_for_rpcv_sim(data_name, est_IP_mult_rpcv_struct.one_evec_by_IP_for_IP, true_IP_vals, is_norm, 'subst_naive_ip_one_evec_by_IP_for_IP');

  compute_mse_var_bias_for_rpcv_sim(data_name, est_IP_mult_rpcv_struct.one_rand_by_ED_for_IP, true_IP_vals, is_norm, 'subst_naive_ip_one_rand_by_ED_for_IP');

  compute_mse_var_bias_for_rpcv_sim(data_name, est_IP_mult_rpcv_struct.one_rand_by_IP_for_IP, true_IP_vals, is_norm, 'subst_naive_ip_one_rand_by_IP_for_IP');





  compute_mse_var_bias_for_rpcv_sim(data_name, li_IP_mult_rpcv_struct.one_evec_by_ED_for_ED, true_ED_vals, is_norm, 'subst_li_ip_one_evec_by_ED_for_ED');

  compute_mse_var_bias_for_rpcv_sim(data_name, li_IP_mult_rpcv_struct.one_evec_by_IP_for_ED, true_ED_vals, is_norm, 'subst_li_ip_one_evec_by_IP_for_ED');

  compute_mse_var_bias_for_rpcv_sim(data_name, li_IP_mult_rpcv_struct.one_rand_by_ED_for_ED, true_ED_vals, is_norm, 'subst_li_ip_one_rand_by_ED_for_ED');

  compute_mse_var_bias_for_rpcv_sim(data_name, li_IP_mult_rpcv_struct.one_rand_by_IP_for_ED, true_ED_vals, is_norm, 'subst_li_ip_one_rand_by_IP_for_ED');

  compute_mse_var_bias_for_rpcv_sim(data_name, li_IP_mult_rpcv_struct.one_evec_by_ED_for_IP, true_IP_vals, is_norm, 'subst_li_ip_one_evec_by_ED_for_IP');

  compute_mse_var_bias_for_rpcv_sim(data_name, li_IP_mult_rpcv_struct.one_evec_by_IP_for_IP, true_IP_vals, is_norm, 'subst_li_ip_one_evec_by_IP_for_IP');

  compute_mse_var_bias_for_rpcv_sim(data_name, li_IP_mult_rpcv_struct.one_rand_by_ED_for_IP, true_IP_vals, is_norm, 'subst_li_ip_one_rand_by_ED_for_IP');

  compute_mse_var_bias_for_rpcv_sim(data_name, li_IP_mult_rpcv_struct.one_rand_by_IP_for_IP, true_IP_vals, is_norm, 'subst_li_ip_one_rand_by_IP_for_IP');



end


