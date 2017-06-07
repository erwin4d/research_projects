function [ rmse, rel_bias] = compute_exp_and_MSE(err_mat, paras, tosave)
  
  % Computed expected value and MSE
  % err_mat must be an input where rows are iter, cols are each k in kvec

  mean_ip = mean(err_mat,1);
  rel_bias = abs((mean_ip-paras.trueval)/paras.trueval);

  rmse = abs(sqrt(sum((err_mat - paras.trueval).^2,1)/size(err_mat,1))/paras.trueval);
  if tosave
    str_var1 = ['li_results/', paras.data_name, '_', paras.tag, '_bias_', num2str(paras.nsims), '_iter.csv'];
    str_var2 = ['li_results/', paras.data_name, '_', paras.tag, '_rmse_', num2str(paras.nsims), '_iter.csv'];    
    csvwrite(str_var1, rel_bias);  
    csvwrite(str_var2, rmse);  
  end


end

