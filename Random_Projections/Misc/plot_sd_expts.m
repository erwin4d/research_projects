function [ ] = plot_sd_expts(kvec, rmse_mat, iter_num, legname, coltype)

  rmse_var = 3*sqrt(var(rmse_mat(1:iter_num,:),0,1));

  plot(kvec,rmse_var, ['--', coltype], 'DisplayName', legname); hold all;

end