function [RMSE_TOTAL] = find_RMSE_for_generic_distance(X_struct, V_struct, truedist, kvals, typeof)

  % X_struct: A structure with at least two fields, being
  %           .mat: A n by p matrix with n observations and p features
  %           .num_obs: Number of observations

  % V_struct: A structure with at least two fields, being
  %           .mat: A n by k matrix after projection
  %           .num_obs: Number of observations

  % truedist: A structure with at least five fields
  %           .n1_index_start: starting index for block computing of rows
  %           .n2_index_start: starting index for block computing of columns
  %           .n1_index_end:   end index for block computing of rows
  %           .n2_index_end:   end index for block computing of columns
  %           .dist_mat:       true distance matrix (upper triangular form)

  % kvals   : The number of columns of random matrices required for experiments
  
  % typeof: Currently, there are three choices
  %           - euclidean_distance
  %           - squared_euclidean_distance
  %           - dot_product
  

  % The output RMSE_TOTAL is the RMSE over appropriate values of kvals.

  % Author: KK

  % See derivations.pdf for more info

  % We first set the correct str_to_use

  if strcmp(typeof, 'squared_euclidean_distance') | strcmp(typeof, 'dot_product')
    str_to_use = typeof;
  elseif strcmp(typeof, 'euclidean_distance')
    str_to_use = 'squared_euclidean_distance';
  end


  %% easier to loop I think

  RMSE_TOTAL = 0;

  for i = 1:length(truedist.n1_index_start)
    for j = i:length(truedist.n2_index_start)
      
      len_row = (truedist.n1_index_end(i) - truedist.n1_index_start(i) + 1);
      len_col = (truedist.n2_index_end(j) - truedist.n2_index_start(j) + 1);

      % For each "block", we first create a multidimensional array of the block x |kvals|
      % where |kvals| is the number of elements in the vector kvals

      Estimated_Array_small = zeros(len_row,len_col,length(kvals));

      % For each "slice" of the array, we compute the sum of the estimated values for the
      % corresponding values of k

      % For example, if kvals = [5 10 15 20]
      % Then we would have 4 slices of the array as |kvals| = 4
      % The first  slice would be the (sum of) the pairwise distances over k= 1  to k = 5
      % The second slice would be the (sum of) the pairwise distances over k= 6  to k = 10
      % The third  slice would be the (sum of) the pairwise distances over k= 11 to k = 15
      % The fourth slice would be the (sum of) the pairwise distances over k= 16  to k = 20
      
      % Get correct indices of start and end
      k_start = [1, kvals(1:(end-1))+1];
      k_end = [k_start(2)-1, kvals(2:end)];

      for k_idx = 1:length(kvals)
        k_startnum = k_start(k_idx);
        k_endnum = k_end(k_idx);
        V_tmp = V_struct;
        V_tmp.mat = V_struct.mat(:,k_startnum:k_endnum);
        estimated_mat = get_pairwise_distances(V_tmp.mat(truedist.n1_index_start(i):truedist.n1_index_end(i),:),V_tmp.mat(truedist.n2_index_start(j):truedist.n2_index_end(j),:), str_to_use);
        if i == j
          Estimated_Array_small(:,:,k_idx) = triu(estimated_mat.dist_mat,1);
        else
          Estimated_Array_small(:,:,k_idx) = estimated_mat.dist_mat;
        end
      end
      
      % cumsum across 3rd dimension
      Estimated_Array_small = cumsum(Estimated_Array_small,3);
      
      % Divide by proper scaling factor of k (is there a way to vectorize this ? )
      for k_idx = 1:length(kvals)
        Estimated_Array_small(:,:,k_idx) = Estimated_Array_small(:,:,k_idx)/kvals(k_idx);
      end
      
      if strcmp(typeof, 'euclidean_distance')
        Estimated_Array_small = sqrt(Estimated_Array_small);
      end

      RMSE_TOTAL = RMSE_TOTAL + sum(squeeze(sum((Estimated_Array_small - truedist.dist_mat(truedist.n1_index_start(i):truedist.n1_index_end(i),truedist.n2_index_start(j):truedist.n2_index_end(j))).^2,1)),1);
    end
  end
  
  RMSE_TOTAL = sqrt(RMSE_TOTAL / X_struct.total_pairwise);

end
      
  