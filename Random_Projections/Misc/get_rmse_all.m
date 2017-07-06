function [rmse] = get_rmse_all(curr_est, para, xseg, yseg)
 

  if xseg ~= yseg
    rmse = sum(sum((curr_est - (para.true_val(para.partition_start(xseg):para.partition_end(xseg), para.partition_start(yseg):para.partition_end(yseg)))).^2));
  else
    rmse = sum(sum((triu(curr_est) - (para.true_val(para.partition_start(xseg):para.partition_end(xseg), para.partition_start(yseg):para.partition_end(yseg)))).^2));
  end        


end
      
  