function [results_mat] = compare_generic_distance_simulation(X_struct, kvals, numiter, typeof)
  
  truedist = get_pairwise_distances(X_struct,X_struct, typeof);
  truedist.dist_mat = triu(truedist.dist_mat,1);  
  results_mat = zeros(numiter, length(kvals));
  
  for iter_num = 1:numiter
  	iter_num
  	[R_struct] = generate_normal_R(X_struct, max(kvals));
  	[V_struct] = compute_V_for_random_projection(X_struct, R_struct);

    [Estimated_Array] = create_array_for_cumsum(X_struct, V_struct, kvals, typeof);
    
    results_mat(iter_num,:) = compute_RMSE_mult_array(truedist.dist_mat, Estimated_Array, X_struct.total_pairwise);
  end
  
end
      
  