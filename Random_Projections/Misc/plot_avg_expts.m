function [ ] = plot_avg_expts(kvec, rmse_mat, iter_num, legname, coltype)

  rmse_mean = mean(rmse_mat(1:iter_num,:),1);

  plot(kvec,rmse_mean, ['-', coltype], 'DisplayName', legname); hold all;

end

