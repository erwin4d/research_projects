function [est_vals ] = run_RPCV_ED_task_one_sim(small_V_EDPair1, small_V_EDPair2, types)
 
  if types == 1
    est_vals = compute_generic_ED_mats(small_V_EDPair1,small_V_EDPair2, true, 'option','normal', 'opt_para', -1, 'is_sim', false);
  elseif types == 2
    est_vals = compute_generic_ED_mats(small_V_EDPair1,small_V_EDPair2, true, 'option','binary', 'opt_para', -1, 'is_sim', false);  
  elseif types == 3
    est_vals = compute_generic_ED_mats(small_V_EDPair1,small_V_EDPair2, true, 'option','SB', 'opt_para', 5, 'is_sim', false);  
  elseif types == 4
    est_vals = compute_generic_ED_mats(small_V_EDPair1,small_V_EDPair2, true, 'option','SB', 'opt_para', 10, 'is_sim', false);  
  elseif types == 5
    est_vals = compute_generic_ED_mats(small_V_EDPair1,small_V_EDPair2, true, 'option','SRHT', 'opt_para', -1, 'is_sim', false);  
  end
        






end