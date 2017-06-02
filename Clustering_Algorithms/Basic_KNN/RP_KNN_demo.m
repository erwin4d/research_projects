function [ ] = RP_KNN_demo(data_name, nsims, num_neigh, is_norm, is_cv)
  
  % Demo KNN with Random Projections
  % Inspired by class homework for BTRY 6520
  
  % Type of matrix used (change this if needed)
  option = 'normal';
  opt_para = 1;

  % Load in datasets
  [ XTrain, XTest, YTrain, YTest, kvec, true_par, XTrainNorm, XTestNorm, split_vals] = load_datasets_for_basic_knn(data_name, num_neigh, is_norm);
  
  %split_vals = min(size(XTest,1), 100);

  size_Train = size(XTrain,1);
  size_Test = size(XTest,1);
  max_k = max(kvec);

  if is_cv
    err_mat_RPCV = zeros(length(kvec), nsims);
  end

  err_mat = zeros(length(kvec), nsims);

  figure;
  for iter = 1:nsims
    iter
    big_V = gen_typeof_V([XTrain; XTest], 1000, 'option', option, 'opt_para', opt_para);
    %big_V = gen_typeof_V([XTrain; XTest], max_k, 'option', option, 'opt_para', opt_para);
    VXTrain = big_V(1:size_Train,:);
    VXTest = big_V((size_Train+1):end,:);

    for kval = 1 : length(kvec)
      %kval
      k = kvec(kval);
      %big_V = gen_typeof_V([XTrain; XTest], k, 'option', option, 'opt_para', opt_para);
      %VXTrain = big_V(1:size_Train,:);
      %VXTest = big_V((size_Train+1):end,:);
      samp_idx = randsample(1000,k);
  
      [subset_VXTrain , subset_VXTest] = debug_KNN(  VXTrain(:,samp_idx), VXTest(:,samp_idx), k);
      labels = basic_KNN(subset_VXTrain, subset_VXTest , YTrain, 2, num_neigh, split_vals, false,XTrainNorm, XTestNorm);
      err_mat(kval, iter) = sum(labels == YTest)/size_Test;

      if is_cv
        labels = basic_KNN( subset_VXTrain, subset_VXTest , YTrain, 2, num_neigh, split_vals, true, XTrainNorm, XTestNorm);
        err_mat_RPCV(kval, iter) = sum(labels == YTest)/size_Test;
      end
    end

    if mod(iter, 5) == 0
      [ avg_err, sd_err] = compute_acc_err_KNN(err_mat(:,1:iter), data_name, iter, false, is_norm);
      clf('reset')    
      if is_cv
        [ avg_err_RPCV, sd_err_RPCV] = compute_acc_err_RPCV_KNN(err_mat_RPCV(:,1:iter), data_name, iter, false);
        local_plot_rel_err_RPCV(kvec, sd_err, avg_err_RPCV, sd_err_RPCV, iter, data_name, false)
      else
        local_plot_rel_err(kvec, avg_err_RPCV, sd_err_RPCV, iter, data_name, false)
      end
      drawnow
    end

    if mod(iter, 10) == 0
      compute_acc_err_KNN(err_mat(:,1:iter), data_name, iter, true, is_norm);
      compute_acc_err_RPCV_KNN(err_mat_RPCV(:,1:iter), data_name, iter, true);
    end
  end

  [ avg_err, sd_err] = compute_acc_err_KNN(err_mat(:,1:iter), data_name, iter, true, is_norm);
  [ avg_err_RPCV, sd_err_RPCV] = compute_acc_err_RPCV_KNN(err_mat_RPCV(:,1:iter), data_name, iter, true);  
  
  if ~is_cv
    local_plot_rel_err(kvec, true_par, avg_err,sd_err,iter, data_name, true)
  else
    local_plot_rel_err_RPCV(kvec, sd_err, avg_err_RPCV, sd_err_RPCV, iter, data_name, true)
  end
end


function [ ] = local_plot_rel_err(kvec, true_par, avg_err, sd_err, iter, data_name, fig_para)

  if fig_para
    figure;
  end

  plot(kvec,avg_err, '-r', 'DisplayName', 'RP Misclassification Error'); hold all
  plot(kvec,repmat(true_par,1,length(kvec)), '-b', 'DisplayName', 'Misclassification Error');
  plot(kvec, avg_err + sd_err, '--m',  'DisplayName', '1SD errs')
  plot(kvec, avg_err - sd_err, '--m', 'DisplayName', '1SD errs')
  plot(kvec, avg_err + 2*sd_err, '--c', 'DisplayName', '2SD errs')
  plot(kvec, avg_err - 2*sd_err, '--c', 'DisplayName', '2SD errs')
  plot(kvec, avg_err + 3*sd_err, '--g', 'DisplayName', '3SD errs')
  plot(kvec, avg_err - 3*sd_err, '--g', 'DisplayName', '3SD errs')


  grid on;
  title(['Misclassification error for ', data_name, ' at ', num2str(iter), ' iterations'], 'FontWeight', 'bold');
  xlabel('Number of columns K', 'FontWeight', 'bold');
  legend('-DynamicLegend', 'location', 'southeast');
  ylabel('Missclassificaton Error', 'FontWeight', 'bold');

end


function [ ] = local_plot_rel_err_RPCV(kvec, sd_err, avg_err_RPCV, sd_err_RPCV, iter, data_name, fig_para)

  if fig_para
    figure;
  end

  plot(kvec,sd_err, '-r', 'DisplayName', 'RP Misclassification Error SD'); hold all
  plot(kvec,sd_err_RPCV, '-b', 'DisplayName', 'RPCV Misclassification Error SD'); 


  grid on;
  title(['Misclassification error for ', data_name, ' at ', num2str(iter), ' iterations'], 'FontWeight', 'bold');
  xlabel('Number of columns K', 'FontWeight', 'bold');
  legend('-DynamicLegend', 'location', 'northeast');
  ylabel('SD of Missclassificaton Error', 'FontWeight', 'bold');

end

