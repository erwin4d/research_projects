function [theo_var, est_var] = verify_variance_generic_distance_simulation(X_struct, kvals, numiter, typeof)
  
  truedist = get_pairwise_distances(X_struct,X_struct, typeof);
  
  truedist = truedist.dist_mat(1,2);
  
  if strcmp(typeof, 'squared_euclidean_distance')
    theo_var = (2*(truedist^2))./(kvals);
  elseif strcmp(typeof, 'dot_product')
    theo_var = (truedist^2 + prod(sum(X_struct.mat.^2,2)))./kvals;
  end

  results_mat = zeros(numiter, length(kvals));
  
  for iter_num = 1:numiter
  	iter_num
  	[R_struct] = generate_normal_R(X_struct, max(kvals));
  	[V_struct] = compute_V_for_random_projection(X_struct, R_struct);

    [Estimated_Array] = create_array_for_cumsum(X_struct, V_struct, kvals, typeof);

    results_mat(iter_num,:) = squeeze(Estimated_Array(1,2,:))';
  end
  est_var = var(results_mat);
end
      
  