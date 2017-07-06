function [] = compute_mse_var_bias_for_rpcv_sim(data_name, err_mat, true_val, is_norm, oth_name)
  
  err_mat = err_mat.store;
  [iter, pectiles, len_kvec, ~] = size(err_mat);

  START_STR = ['rpcv_results/', data_name, '_'];
  ITER_STR = ['_', num2str(iter), '_iter_'];
  
  if is_norm
    NORMALIZED_STR = '_normalized_for_';
  else
    NORMALIZED_STR = '_unnormalized_for_';
  end

  % Normal random matrix
  MAT_STR = 'normal_mat';
  compute_bias_rpcv_sim_helper(err_mat(:,:,:,1), pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)
  
  compute_var_rpcv_sim_helper(err_mat(:,:,:,1), pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)
  compute_mse_rpcv_sim_helper(err_mat(:,:,:,1), pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)

  MAT_STR = 'binary_mat';
  compute_bias_rpcv_sim_helper(err_mat(:,:,:,2), pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)
  compute_var_rpcv_sim_helper(err_mat(:,:,:,2), pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)
  compute_mse_rpcv_sim_helper(err_mat(:,:,:,2), pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)


  MAT_STR = 'SB5_mat';
  compute_bias_rpcv_sim_helper(err_mat(:,:,:,3), pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)
  compute_var_rpcv_sim_helper(err_mat(:,:,:,3), pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)
  compute_mse_rpcv_sim_helper(err_mat(:,:,:,3), pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)



  MAT_STR = 'SB10_mat';
  compute_bias_rpcv_sim_helper(err_mat(:,:,:,4), pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)
  compute_var_rpcv_sim_helper(err_mat(:,:,:,4), pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)
  compute_mse_rpcv_sim_helper(err_mat(:,:,:,4), pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)



  MAT_STR = 'SRHT_mat';
  compute_bias_rpcv_sim_helper(err_mat(:,:,:,5), pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)
  compute_var_rpcv_sim_helper(err_mat(:,:,:,5), pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)
  compute_mse_rpcv_sim_helper(err_mat(:,:,:,5), pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)


end

