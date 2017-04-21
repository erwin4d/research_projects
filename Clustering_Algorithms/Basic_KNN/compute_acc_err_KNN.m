function [ ] = compute_acc_err_KNN(err_mat, data_name, nsims)

  % Simply computes mean classisfication error and its standard deviation
  % from a matrix storing classification erros at varying iterations and projection col number

  avg_err = mean(err_mat,2);
  sd_err = sqrt(var(err_mat,0,2));
  
  str_var = ['knn_data/', data_name, '_avg_err_with_', num2str(nsims), '_iter.csv'];
  csvwrite(str_var, avg_err);  
  
  str_var = ['knn_data/', data_name, '_sd_with_', num2str(nsims), '_iter.csv'];
  csvwrite(str_var, sd_err);  
  

end

