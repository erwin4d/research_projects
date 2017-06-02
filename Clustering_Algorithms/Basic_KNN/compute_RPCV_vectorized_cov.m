function [ dist_mat ] = compute_RPCV_vectorized_cov(VXTrain, VXTest, norm_XTrain, norm_XTest)
  
  % cov_mat is respective cov(i,j), where ith row corresponds to ith observation in VXTrain
  % j col corresponds to jth observation in VXTest

  [size_Train, num_obs] = size(VXTrain);
  size_Test = size(VXTest,1);

  VXTrain_Square = repmat(sum(VXTrain.^2,2),1,size_Test);
  VXTest_Square = repmat(sum(VXTest.^2,2),1,size_Train)';

  mean_of_ED = (VXTrain_Square  -2 * VXTrain * VXTest' +VXTest_Square);%/num_obs;
  mean_of_sum_of_norms = (VXTrain_Square +VXTest_Square); %/num_obs;
  
  % Really just expanding the brackets of cov 
  cov_mat = repmat(sum(VXTest.^4,2),1,size_Train)' + repmat(sum(VXTrain.^4,2),1,size_Test) + 2 * VXTrain.^2 * VXTest.^2';
  var_mat = cov_mat; % They share the same parts

  cov_mat = cov_mat -2 * (VXTrain * (VXTest.^3)' +  VXTrain.^3 * (VXTest)');
  cov_mat = cov_mat -mean_of_ED .* (VXTest_Square + VXTrain_Square);

  cov_mat = cov_mat -mean_of_sum_of_norms .* (VXTest_Square + VXTrain_Square - 2*(VXTrain * VXTest'));

  cov_mat = cov_mat + mean_of_ED .* mean_of_sum_of_norms * num_obs;


  var_mat = var_mat - 2* mean_of_sum_of_norms .* (VXTrain_Square + VXTest_Square);
  var_mat = var_mat + num_obs * mean_of_sum_of_norms.^2;


  c_vec = cov_mat ./ var_mat;

  true_sum_norms = norm_XTrain * norm_XTest';

  dist_mat = sqrt(abs(mean_of_ED - c_vec .* (mean_of_sum_of_norms - true_sum_norms)));
  
  %no_mean_of_ED = (VXTrain_Square  -2 * VXTrain * VXTest' +VXTest_Square);
  %no_mean_of_sum_of_norms = (VXTrain_Square +VXTest_Square);

  %dist_mat = sqrt((no_mean_of_ED + c_vec .* (no_mean_of_sum_of_norms - true_sum_norms))/num_obs);


end

