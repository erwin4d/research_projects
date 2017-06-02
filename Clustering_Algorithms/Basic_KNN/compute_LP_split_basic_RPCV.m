function [ labels ] = compute_LP_split_basic_RPCV( XTrain, XTest, YTrain, split_num, k_neigh, norm_XTrain, norm_XTest)

  % See our vectorized form
  [ dist_mat ] = compute_RPCV_vect_theo_cov(XTrain, XTest, norm_XTrain, norm_XTest);
  
  labels = zeros(1, split_num);
  for zcol = 1:split_num
    [~, idx] = sort(dist_mat(:,zcol));
    labels(zcol) = mode(YTrain(idx(1:k_neigh)));
  end

end

