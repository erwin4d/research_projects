function [ ] = RP_KNN_demo(data_name, nsims)

  % Demo KNN with Random Projections
  % Inspired by class homework for BTRY 6520
  
  % Type of matrix used (change this if needed)
  option = 'binary';
  opt_para = 0;

  if strcmp(data_name, 'mnist')
    [XTrain, XTest, YTrain, YTest] = load_MNIST();
    kvec = [20, 50, 100, 150, 200, 250];
    true_par = 0.9688;
    % Baseline error for MNIST is.....
    % 0.9688 for p = 2
  elseif strcmp(data_name, 'gisette')
    XTrain = csvread('gisette_train.csv');
    YTrain = csvread('gisette_train_label.csv');
    XTest = csvread('gisette_valid.csv');
    YTest = csvread('gisette_valid_label.csv');
    kvec = [10, 20, 30, 40, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500];
    true_par = 0.9560;
    % 0.9560 for p = 2
  elseif strcmp(data_name, 'arcene')
    XTrain = csvread('arcene_train.csv');
    YTrain = csvread('arcene_train_labels.csv');
    XTest = csvread('arcene_valid.csv');
    YTest = csvread('arcene_valid_labels.csv');
    kvec = [10, 20, 30, 40, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 600, 700, 800, 900, 1000];
    true_par = 0.7800;
    %  0.7800 p = 2
  
  end
  near_neigh = 5;
  % labels  = basic_KNN( XTrain, XTest, YTrain, 2, near_neigh, 100);

  size_Train = size(XTrain,1);
  size_Test = size(XTest,1);
  max_k = max(kvec);
  err_mat = zeros(length(kvec), nsims);

  figure;
  for iter = 1:nsims
    iter
    big_V = gen_typeof_V([XTrain; XTest], max_k, 'option', option, 'opt_para', opt_para);
    VXTrain = big_V(1:size_Train,:);
    VXTest = big_V((size_Train+1):end,:);

    for kval = 1 : length(kvec)
      %kval
      k = kvec(kval);
      labels = basic_KNN( VXTrain(:,1:k), VXTest(:,1:k), YTrain, 2, near_neigh, 100);
      err_mat(kval, iter) = sum(labels == YTest)/size_Test;
    end

    if mod(iter, 20) == 0
      [ avg_err, sd_err] = compute_acc_err_KNN(err_mat(:,1:iter), data_name, iter, false);
      clf('reset')    
      local_plot_rel_err(kvec, true_par, avg_err,sd_err, iter, data_name, false)
      drawnow
    end

    if mod(iter, 100) == 0
      compute_acc_err_KNN(err_mat(:,1:iter), data_name, iter, true);
    end
  end

  [ avg_err, sd_err] = compute_acc_err_KNN(err_mat(:,1:iter), data_name, iter, 'tosave', true);
  
  
  local_plot_rel_err(kvec, true_par, avg_err,sd_err,iter, data_name, true)

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
