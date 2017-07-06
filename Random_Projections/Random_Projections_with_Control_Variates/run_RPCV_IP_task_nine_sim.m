function [est_vals ] = run_RPCV_IP_task_nine_sim(small_V_IPPair1, small_V_IPPair2, sqnormIPPair1, sqnormIPPair2, est_of_ip, types)

  % This computes the empirical control variate given two pairs
  % Not really going to vectorize this (see KNN code for vectorized version)
  small_V_IPPair1 = small_V_IPPair1.vmat;
  small_V_IPPair2 = small_V_IPPair2.vmat;
  
  if types == 1
    Avec = (small_V_IPPair1 .* small_V_IPPair2);
    Bvec = small_V_IPPair1.^2 + small_V_IPPair2.^2;

  elseif types == 2
    Avec = (small_V_IPPair1 .* small_V_IPPair2);
    Bvec = small_V_IPPair1.^2 + small_V_IPPair2.^2;

  elseif types == 3
    Avec = 5*(small_V_IPPair1 .* small_V_IPPair2);
    Bvec = 5*(small_V_IPPair1.^2 + small_V_IPPair2.^2);

  elseif types == 4
    Avec = 10*(small_V_IPPair1 .* small_V_IPPair2);
    Bvec = 10*(small_V_IPPair1.^2 + small_V_IPPair2.^2);

  elseif types == 5
    Avec = (small_V_IPPair1 .* small_V_IPPair2);
    Bvec = (small_V_IPPair1.^2 + small_V_IPPair2.^2);

  end

  opt_c = (sqnormIPPair1.*est_of_ip + sqnormIPPair2.*est_of_ip )./ (sqnormIPPair1.^2 + sqnormIPPair2.^2 + 2*est_of_ip.^2);

  est_vals = (mean(Avec - opt_c .* ( Bvec - sqnormIPPair1 - sqnormIPPair2),2));



end