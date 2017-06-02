function [est_vals ] = run_RPCV_ED_task_three_sim(small_V_EDPair1, small_V_EDPair2, sqnormEDPair1, sqnormEDPair2, types)

  % This computes the empirical control variate given two pairs
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
  
  cov_vec = zeros(11,1);
  var_vec = zeros(11,1);
  for j = 1:11;
    cc = cov(Avec(j,:), Bvec(j,:));
    cov_vec(j) = cc(1,2);
    var_vec(j) = var(Bvec(j,:));
  end
  opt_c = cov_vec ./ var_vec;

  est_vals = sqrt(mean(Avec - opt_c .* ( Bvec - sqnormEDPair1 - sqnormEDPair2),2));



end