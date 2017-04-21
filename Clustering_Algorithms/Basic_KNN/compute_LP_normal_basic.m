function [ labels ] = compute_LP_normal_basic( XTrain, XTestVec, YTrain, sizeTrain, p, k_neigh)

  % Compute lp dist for odd p

  tmp = ones(size_Train, 1) * XTestVec;
  tmp = abs(tmp - XTrain);
  tmp = tmp.^p;
  tmp = sum(tmp,2);
  [~, idx] = sort(tmp);
  labels = mode(YTrain(idx(1:k_neigh)));

end

