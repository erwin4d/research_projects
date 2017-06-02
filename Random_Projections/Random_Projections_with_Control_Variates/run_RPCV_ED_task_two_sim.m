function [est_vals ] = run_RPCV_ED_task_two_sim(sqnormEDPair1, sqnormEDPair2, li_ip_est)
 
  % Compute ED with true norms
  % (x-y)^2 = x^2 + y^2 -2xy so
  %
  %

  est_vals = sqnormEDPair1 + sqnormEDPair2 - 2*li_ip_est;





end