function [ labels ] = compute_RPCV_one_obs_KNN(VXTrain_mat, VXTest_vec, YTrain, num_neigh)
  % Legacy function ; not used (vectorized version used instead)

  % Assumptions: Columns have already been normalized
  % Assumptions: lp norm 2
  % Unvectorized version (see vectorized)

  VXTest_as_mat = repmat(VXTest_vec,size(VXTrain_mat,1),1);

  B_as_mat = VXTest_as_mat.^2 + VXTrain_mat.^2;
  A_as_mat = (VXTest_as_mat - VXTrain_mat).^2;

  dist_vec = zeros(size(A_as_mat,1), 1);
  
  a_tmp = A_as_mat - mean(A_as_mat,2);
  %b_tmp = B_as_mat - mean(B_as_mat,2);
  b_tmp = B_as_mat - 2;


  c_vec = (sum(a_tmp .* b_tmp,2) / (size(VXTrain_mat,2)-1)) ./ var(B_as_mat,0,2);

  dist_vec = mean(A_as_mat + (c_vec .* (B_as_mat - 2)),2);

  [~, idx] = sort(dist_vec);
  labels = mode(YTrain(idx(1:num_neigh)));

end

