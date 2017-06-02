function [ labels ] = compute_LP_split_basic( XTrain, XTest, YTrain, split_num, p, k_neigh, bin_coef)

 % Note that |    |^p when p is even is always positive ; not so when odd
  % This means for even p ,
  % can expand (x-y)^4 to x^4 - 4x^3y + 6x^2y^2 - 4xy^3 + y^4
  % and sum up each term

  % We can't do the above for odd powers because
  % |  |^p is positive but
  % (..)^p could be negative
  % bummer.

  Z = sum(XTrain.^p,2) * ones(1,size(XTest,1)) + transpose(sum(XTest.^p,2) * ones(1, size(XTrain,1)));
  for coef = 2:(length(bin_coef)-1);
      Z = Z + (-1)^(coef-1) * bin_coef(coef) *(XTrain.^(p-coef+1))*transpose((XTest.^(coef-1)));
  end
  Z = sqrt(Z);
  labels = zeros(1, split_num);
  for zcol = 1:split_num
    [~, idx] = sort(Z(:,zcol));
    labels(zcol) = mode(YTrain(idx(1:k_neigh)));
  end

end

