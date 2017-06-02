function [ ip_vals, m1_vals, m2_vals] = run_RPCV_IP_task_seven_helper(small_V_IPPair1, small_V_IPPair2, types)
 
  if types == 1
    ip_vals = compute_generic_IP_mats(small_V_IPPair1,small_V_IPPair2, true, 'option','normal', 'opt_para', -1, 'is_sim', false);
    m1_vals = compute_generic_all_norm( small_V_IPPair1, true, 'option', 'normal', 'opt_para', -1, 'is_sim', false);
    m2_vals = compute_generic_all_norm( small_V_IPPair2, true, 'option', 'normal', 'opt_para', -1, 'is_sim', false);

  elseif types == 2
    ip_vals = compute_generic_IP_mats(small_V_IPPair1,small_V_IPPair2, true, 'option','binary', 'opt_para', -1, 'is_sim', false);  
    m1_vals = compute_generic_all_norm( small_V_IPPair1, true, 'option', 'binary', 'opt_para', -1, 'is_sim', false);
    m2_vals = compute_generic_all_norm( small_V_IPPair2, true, 'option', 'binary', 'opt_para', -1, 'is_sim', false);

  elseif types == 3
    ip_vals = compute_generic_IP_mats(small_V_IPPair1,small_V_IPPair2, true, 'option','SB', 'opt_para', 5, 'is_sim', false);  
    m1_vals = compute_generic_all_norm( small_V_IPPair1, true, 'option', 'SB', 'opt_para', 5, 'is_sim', false);
    m2_vals = compute_generic_all_norm( small_V_IPPair2, true, 'option', 'SB', 'opt_para', 5, 'is_sim', false);


  elseif types == 4
    ip_vals = compute_generic_IP_mats(small_V_IPPair1,small_V_IPPair2, true, 'option','SB', 'opt_para', 10, 'is_sim', false);  
    m1_vals = compute_generic_all_norm( small_V_IPPair1, true, 'option', 'normal', 'opt_para', -1, 'is_sim', false);
    m2_vals = compute_generic_all_norm( small_V_IPPair2, true, 'option', 'normal', 'opt_para', -1, 'is_sim', false);


  elseif types == 5
    ip_vals = compute_generic_IP_mats(small_V_IPPair1,small_V_IPPair2, true, 'option','SRHT', 'opt_para', -1, 'is_sim', false);  
    m1_vals = compute_generic_all_norm( small_V_IPPair1, true, 'option', 'SRHT', 'opt_para', -1, 'is_sim', false);
    m2_vals = compute_generic_all_norm( small_V_IPPair2, true, 'option', 'SRHT', 'opt_para', -1, 'is_sim', false);

  end
        

end