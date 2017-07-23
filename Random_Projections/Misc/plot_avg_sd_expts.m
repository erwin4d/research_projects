function [ ] = plot_avg_sd_expts(kvec, rmse_mat, iter_num, legname, coltype)


  rmse_mean = mean(rmse_mat(1:iter_num,:),1);
  rmse_var = 3*sqrt(var(rmse_mat(1:iter_num,:),0,1));

  min_bound = rmse_mean - rmse_var;
  max_bound = rmse_mean + rmse_var;
  min_bound(min_bound < 0) = 0;
  
  plot(kvec,rmse_mean, ['-', coltype], 'DisplayName', legname); hold all
  plot(kvec,min_bound, ['--', coltype], 'DisplayName', 'Lower 3sd bound'); 
  plot(kvec,max_bound, ['--', coltype], 'DisplayName', 'Upper 3sd bound'); 



end