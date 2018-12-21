function [prop] = compare_generic_distance_epsilon_bounds_simulation(X_struct, kvals, numiter, typeof, eps)
  
  truedist = get_pairwise_distances(X_struct,X_struct, typeof);
  truedist.dist_mat = triu(truedist.dist_mat,1);  
  LB = (1-eps)*truedist.dist_mat(1,2)
  UB = (1+eps)*truedist.dist_mat(1,2)


  results_mat = zeros(1, length(kvals));
  



  for iter_num = 1:numiter
  	if mod(iter_num,100) == 0
      iter_num
    end
  	[R_struct] = generate_normal_R(X_struct, max(kvals));
  	[V_struct] = compute_V_for_random_projection(X_struct, R_struct);

    [Estimated_Array] = create_array_for_cumsum(X_struct, V_struct, kvals, typeof);

    est_distance = squeeze(Estimated_Array(1,2,1:(size(Estimated_Array,3))));

    results_mat = results_mat + (est_distance < LB | est_distance > UB)';
    
  end
  prop = results_mat / numiter;


end
      
  