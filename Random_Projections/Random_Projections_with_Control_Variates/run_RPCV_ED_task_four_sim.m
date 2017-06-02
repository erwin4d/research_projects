function [est_vals ] = run_RPCV_ED_task_four_sim(small_V_EDPair1, small_V_EDPair2, sqnormEDPair1, sqnormEDPair2, est_of_ip, types)

  % This computes the theoretical control variate given two pairs
  % Not really going to vectorize this (see KNN code for vectorized version)
  
 
  if types == 1
    Avec = (small_V_EDPair1 - small_V_EDPair2).^2;
    Bvec = small_V_EDPair1.^2 + small_V_EDPair2.^2;

  elseif types == 2
    Avec = (small_V_EDPair1 - small_V_EDPair2).^2;
    Bvec = small_V_EDPair1.^2 + small_V_EDPair2.^2;

  elseif types == 3
    Avec = 5*(small_V_EDPair1 - small_V_EDPair2).^2;
    Bvec = 5*(small_V_EDPair1.^2 + small_V_EDPair2.^2);

  elseif types == 4
    Avec = 10*(small_V_EDPair1 - small_V_EDPair2).^2;
    Bvec = 10*(small_V_EDPair1.^2 + small_V_EDPair2.^2);

  elseif types == 5
    Avec = (small_V_EDPair1 - small_V_EDPair2).^2;
    Bvec = (small_V_EDPair1.^2 + small_V_EDPair2.^2);

  end
  
  opt_c = ((sqnormEDPair1 - est_of_ip).^2 + (sqnormEDPair2 - est_of_ip).^2)./ (sqnormEDPair1.^2 + sqnormEDPair2.^2 + 2*est_of_ip.^2);

  est_vals = mean(Avec - opt_c .* ( Bvec - sqnormEDPair1 - sqnormEDPair2),2);
  est_vals(est_vals <  0) = 0 ;
  est_vals = sqrt(est_vals);



end