function [ avg_err, sd_err] = compute_acc_err_KNN(err_mat, data_name, nsims, tosave, is_norm)

  % Simply computes mean classisfication error and its standard deviation
  % from a matrix storing classification errors at varying iterations and projection col number



  avg_err = mean(err_mat,2);
  sd_err = sqrt(var(err_mat,0,2));
  
  if tosave
    if is_norm
      str_var = ['knn_data/', data_name, '_avg_err_when_normed_with_', num2str(nsims), '_iter.csv'];    
    else
      str_var = ['knn_data/', data_name, '_avg_err_with_', num2str(nsims), '_iter.csv'];
    end
    csvwrite(str_var, avg_err);  

    if is_norm
      str_var = ['knn_data/', data_name, '_sd_when_normed_with_', num2str(nsims), '_iter.csv'];
    else
      str_var = ['knn_data/', data_name, '_sd_with_', num2str(nsims), '_iter.csv'];
    end

    csvwrite(str_var, sd_err);  
  end

end

