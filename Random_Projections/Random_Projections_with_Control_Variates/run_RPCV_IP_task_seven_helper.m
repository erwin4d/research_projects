function [ ip_vals, m1_vals, m2_vals] = run_RPCV_IP_task_seven_helper(small_V_IPPair1, small_V_IPPair2)
 

  ip_vals = compute_generic_IP_mats(small_V_IPPair1, small_V_IPPair2);
  m1_vals = compute_generic_all_norm(small_V_IPPair1);
  m2_vals = compute_generic_all_norm(small_V_IPPair2);


end