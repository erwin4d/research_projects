function [ ] = RP_KNN_demo(data_name, nsims)

  % Demo KNN with Random Projections
  % Class homework for BTRY 6520

  if strcmp(data_name, 'mnist')
    [XTrain, XTest, YTrain, YTest] = load_MNIST();
    kvec = [20, 50, 100, 150, 200, 250];
    % Baseline error for MNIST is.....
    % 0.9688 for p = 2
  elseif strcmp(data_name, 'gisette')
    XTrain = csvread('gisette_train.csv');
    YTrain = csvread('gisette_train_label.csv');
    XTest = csvread('gisette_valid.csv');
    YTest = csvread('gisette_valid_label.csv');
    kvec = [10, 20, 30, 40, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500];
    % 0.9560 for p = 2
  elseif strcmp(data_name, 'arcene')
    XTrain = csvread('arcene_train.csv');
    YTrain = csvread('arcene_train_labels.csv');
    XTest = csvread('arcene_valid.csv');
    YTest = csvread('arcene_valid_labels.csv');
    kvec = [10, 20, 30, 40, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 600, 700, 800, 900, 1000];
    %  0.7800 p = 2
  
  end
  near_neigh = 5;
  % labels  = basic_KNN( XTrain, XTest, YTrain, 2, near_neigh, 100);

  size_Train = size(XTrain,1);
  size_Test = size(XTest,1);
  max_k = max(kvec);
  err_mat = zeros(length(kvec), nsims);


  for iter = 1:nsims
    iter
    big_V = gen_typeof_V([XTrain; XTest], max_k, 2, 1 );
    VXTrain = big_V(1:size_Train,:);
    VXTest = big_V((size_Train+1):end,:);

    for kval = 1 : length(kvec)
      %kval
      k = kvec(kval);
      labels = basic_KNN( VXTrain(:,1:k)/sqrt(k), VXTest(:,1:k)/sqrt(k), YTrain, 2, near_neigh, 100);
      err_mat(kval, iter) = sum(labels == YTest)/size_Test;
    end
    if mod(iter, 100) == 0
      compute_acc_err_KNN(err_mat(:,1:iter), data_name, iter)
    end
  end

  compute_acc_err_KNN(err_mat(:,1:iter), data_name, iter)


end


