function [] = compute_var_rpcv_sim_helper(red_err_mat, pectiles, len_kvec, true_val, START_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name)
  
  MYFUN_STR = 'var';

  save_str = [START_STR, MYFUN_STR, ITER_STR, MAT_STR, NORMALIZED_STR, oth_name, '.csv'];

  var_mat = zeros(pectiles,len_kvec); 
  for j = 1:11;
    var_mat(j,:) = var(squeeze(red_err_mat(:,j,:)),0,1)';
  end
  rel_var = (var_mat) ./repmat(true_val,1, len_kvec) ;
  rel_var(isnan(rel_var)) = 0;

  csvwrite(save_str, abs(rel_var));  


end

