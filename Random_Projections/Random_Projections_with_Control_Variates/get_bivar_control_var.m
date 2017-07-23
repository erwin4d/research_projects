function [ req_vals ] = get_bivar_control_var(ests, typeof)

  cv_corr = (ests.small_v1norm + ests.small_v2norm - 2*ones(ests.n1, ests.n2));

  % We have four types, if we want to substitute a first estimate of the inner product:
  % The empirical computation of the control variate is in the get_V_ests_all.m function
  
  if strcmp(typeof, 'theo_euclidean_distance_naive') || strcmp(typeof, 'theo_inner_product_naive')
    ip_to_use = ests.small_v1v2;
  elseif strcmp(typeof, 'theo_euclidean_distance_li') || strcmp(typeof, 'theo_inner_product_li')
    ip_to_use = ests.small_li_ip;
  end

  if strcmp(typeof, 'theo_euclidean_distance_naive') || strcmp(typeof, 'theo_euclidean_distance_li')
    chat = (ones(ests.n1, ests.n2) - ip_to_use).^2 ./ (ones(ests.n1, ests.n2) + ip_to_use.^2);
    req_vals = ests.small_euc_dist - chat .* cv_corr;
  end

  if strcmp(typeof, 'theo_inner_product_naive') || strcmp(typeof, 'theo_inner_product_li')
    chat = ip_to_use ./ ( ones(ests.n1, ests.n2) + ip_to_use.^2);
    req_vals = ests.small_v1v2 - chat .* cv_corr;
  end




end

