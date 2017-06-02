function [] = compute_bias_rpcv_sim_helper(red_err_mat, pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)
  
  MYFUN_STR = 'bias';

  save_str = [START_STR, MYFUN_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name, '.csv'];

  bias_mat = zeros(pectiles,len_kvec); 
  for j = 1:11;
    bias_mat(j,:) = mean(squeeze(red_err_mat(:,j,:)),1)';
  end
  rel_bias = (bias_mat - repmat(true_val,1, len_kvec)) ./repmat(true_val,1, len_kvec) ;
  rel_bias(isnan(rel_bias)) = 0;

  csvwrite(save_str, abs(rel_bias));  


end

