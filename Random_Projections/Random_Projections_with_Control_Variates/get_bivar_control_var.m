function [ req_vals ] = get_bivar_control_var(ests, typeof)

  v1v2_mat = ests.v1v2;
  v1norm_mat = ests.v1norm;
  v2norm_mat = ests.v2norm;

  % We have four types, if we want to substitute a first estimate of the inner product:
  % The empirical computation of the control variate is in the get_V_ests_all.m function
  
  if strcmp(typeof, 'theo_euclidean_distance_naive') || strcmp(typeof, 'theo_inner_product_naive')
    ip_to_use = ests.v1v2;
  elseif strcmp(typeof, 'theo_euclidean_distance_li') || strcmp(typeof, 'theo_inner_product_li')
    ip_to_use = ests.li_ip;
  end

  if strcmp(typeof, 'theo_euclidean_distance_naive') || strcmp(typeof, 'theo_euclidean_distance_li')
    chat = (ones(ests.n1, ests.n2) - ip_to_use).^2 ./ (ones(ests.n1, ests.n2) + ip_to_use.^2);
    req_vals = ests.v1norm + ests.v2norm - 2*ests.v1v2 - chat .* (ests.v1norm + ests.v2norm - 2*ones(ests.n1, ests.n2));
  end

  if strcmp(typeof, 'theo_inner_product_naive') || strcmp(typeof, 'theo_inner_product_li')
    chat = ip_to_use ./ ( ones(ests.n1, ests.n2) + ip_to_use.^2);
    req_vals = ests.v1v2 - chat .* (ests.v1norm + ests.v2norm - 2*ones(ests.n1, ests.n2));
  end




end

