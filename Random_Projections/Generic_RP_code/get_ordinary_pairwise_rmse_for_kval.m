function [rmse_val] = get_ordinary_pairwise_rmse_for_kval(V, k, true_val, tot_num, partition_x, partition_y, pairwise)
  
  V_est = V.vmat(:,1:k);
  para_est = triu(get_true_vals(V_est, partition_x, partition_y, pairwise)) / k * V.scaling_factor;
  rmse_val = sqrt(sum(sum( (triu(para_est) - triu(true_val)).^2))/tot_num);

end
      
  