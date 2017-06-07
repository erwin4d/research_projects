function [ rmse, rel_bias] = compute_exp_and_MSE(err_mat, exp_value, word1, word2, nsims, varargin)
  

  p = inputParser;  
  p.addRequired('err_mat',@(x) true);
  p.addRequired('exp_value',@isscalar);
  p.addRequired('word1',@ischar);
  p.addRequired('word2',@ischar);
  p.addRequired('nsims',@isscalar);
  p.addOptional('option', 'ordinary', @(x) any(strcmp(x,{'ordinary', 'MLE'})));
  p.addOptional('tosave', false, @(x) true);
  p.parse(err_mat, exp_value, word1, word2, nsims, varargin{:});
  inputs = p.Results;


  % Computed expected value and MSE
  % err_mat must be an input where rows are iter, cols are each k in kvec

  mean_ip = mean(err_mat,1);
  rel_bias = abs((mean_ip-exp_value)/exp_value);

  rmse = abs(sqrt(sum((err_mat - exp_value).^2,1)/size(err_mat,1))/exp_value);
  if inputs.tosave
    if strcmp(inputs.option, 'ordinary')
      str_var1 = ['li_results/', word1, '_', word2, '_', 'rel_IP_bias_with_', num2str(nsims), '_iter.csv'];
      str_var2 = ['li_results/', word1, '_', word2, '_', 'rel_rmse_with_', num2str(nsims), '_iter.csv'];
    else
      str_var1 = ['li_results/', word1, '_', word2, '_', 'MLE_rel_IP_bias_with_', num2str(nsims), '_iter.csv'];    
      str_var2 = ['li_results/', word1, '_', word2, '_', 'MLE_rel_rmse_with_', num2str(nsims), '_iter.csv'];
    end
    csvwrite(str_var1, rel_bias);  
    csvwrite(str_var2, rmse);  
  end


end

