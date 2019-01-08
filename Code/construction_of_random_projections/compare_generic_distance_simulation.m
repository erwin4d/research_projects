function [results_mat] = compare_generic_distance_simulation(X_struct, kvals, numiter, typeof)
  
  truedist = get_pairwise_distances_big(X_struct,X_struct, typeof);
  truedist.dist_mat = triu(truedist.dist_mat,1);  
  results_mat = zeros(numiter, length(kvals));


  
  for iter_num = 1:numiter
  	iter_num
  	[R_struct] = generate_normal_R(X_struct, max(kvals));
  	[V_struct] = compute_V_for_random_projection(X_struct, R_struct);
    results_mat(iter_num,:) = find_RMSE_for_generic_distance(X_struct, V_struct, truedist, kvals, typeof);
  end
  
end
      
  