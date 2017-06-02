function [] = compute_mse_rpcv_sim_helper(red_err_mat, pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)
  
  MYFUN_STR = 'mse';

  save_str = [START_STR, MYFUN_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name, '.csv'];
  
  the_iter = size(red_err_mat,1);
  mse_mat = zeros(pectiles,len_kvec); 
  for j = 1:11;
  	sum((squeeze(red_err_mat(:,j,:)) - true_val(j)).^2,1)/the_iter;
    mse_mat(j,:) = sum((squeeze(red_err_mat(:,j,:)) - true_val(j)).^2,1)/the_iter;
  end
  rel_mse = (mse_mat) ./repmat(true_val,1, len_kvec) ;
  rel_mse(isnan(rel_mse)) = 0;

  csvwrite(save_str, abs(rel_mse));  


end

