function [ ] = RPCV_KNN_demo(data_name, nsims, num_neigh)
  
  % Demo KNN with Random Projections + Control Variates
  % Code is mostly identical to RP_KNN_demo.m ; except for control variate part
  % May merge both of them 

  % Since we normalized the data ; our norms are 1 anyway.

  % Type of matrix used (change this if needed)
  option = 'normal';
  opt_para = 1;
  
  % Load in datasets
  [ XTrain, XTest, YTrain, YTest, kvec, true_par] = load_datasets_for_basic_knn(data_name, num_neigh, true);
  

  size_Train = size(XTrain,1);
  size_Test = size(XTest,1);
  max_k = max(kvec);

  err_mat = zeros(length(kvec), nsims);
  err_mat_RPCV = zeros(length(kvec), nsims);

  figure;
  for iter = 1:nsims
    iter
    big_V = gen_typeof_V([XTrain; XTest], max_k, 'option', option, 'opt_para', opt_para);
    VXTrain = big_V(1:size_Train,:);
    VXTest = big_V((size_Train+1):end,:);

    for kval = 1 : length(kvec)
      %kval
      k = kvec(kval);
      
      % Ordinary RP
      labels = basic_KNN( VXTrain(:,1:k), VXTest(:,1:k), YTrain, 2, num_neigh, 100);
      err_mat(kval, iter) = sum(labels == YTest)/size_Test;
      
      % With RPCV
      labels = zeros(size_Test, 1);
      for z = 1:size_Test
        labels(z) = compute_RPCV_one_obs_KNN(VXTrain(:,1:k), VXTest(z, 1:k), YTrain, num_neigh);
      end
      err_mat_RPCV(kval, iter) = sum(labels == YTest)/size_Test;

    end

    if mod(iter, 10) == 0
      [ avg_err, sd_err] = compute_acc_err_KNN(err_mat(:,1:iter), data_name, iter, false, true);
      [ avg_err_RPCV, sd_err_RPCV] = compute_acc_err_RPCV_KNN(err_mat_RPCV(:,1:iter), data_name, iter, false);

      clf('reset')    
      local_plot_rel_err(kvec, avg_err,sd_err, avg_err_RPCV, sd_err_RPCV, iter, data_name, false)
      drawnow
    end

    if mod(iter, 20) == 0
      compute_acc_err_KNN(err_mat(:,1:iter), data_name, iter, true, true);
      compute_acc_err_RPCV_KNN(err_mat_RPCV(:,1:iter), data_name, iter, true);
    end
  end

  [ avg_err, sd_err] = compute_acc_err_KNN(err_mat(:,1:iter), data_name, iter, true, true);
  [ avg_err_RPCV, sd_err_RPCV] = compute_acc_err_RPCV_KNN(err_mat_RPCV(:,1:iter), data_name, iter, true);

  
  local_plot_rel_err(kvec, avg_err,sd_err, avg_err_RPCV, sd_err_RPCV, iter, data_name, false)

end


function [ ] = local_plot_rel_err(kvec, avg_err, sd_err, avg_err_RPCV, sd_err_RPCV, iter, data_name, fig_para)

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
