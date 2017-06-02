function [XTrain, XTest, YTrain, YTest, kvec, true_par, XTrainNorm, XTestNorm, split_vals] = load_datasets_for_basic_knn(data_name, num_neigh, is_norm)

  % This function loads datasets for basic_KNN, initializes kvec, as well as gives classification accuracy
  % for actual nearest neighbors for a given neighbor.

  % The function reads a CSV file where the nearest neighbors accuracy are stored
  % If the result had not been computed previously, the classification accuracy is computed
  % Otherwise it is read directly from the CSV file to save time.


  DATASETS = 4; % Update this each time we have a new dataset for KNN
  if is_norm
    BASIC_KNN_CSV_NAME = 'basic_KNN_normed_NN_values.csv';
  else
    BASIC_KNN_CSV_NAME = 'basic_KNN_NN_values.csv';
  end

  nn_comparison = feval('load', BASIC_KNN_CSV_NAME);
  [max_neigh, num_datasets] = size(nn_comparison);
  if max_neigh < num_neigh
    'Error'
    return
  end

  if num_datasets ~= DATASETS;
    'Error'
    return
  end

  if strcmp(data_name, 'mnist')
    data_pos = 1;
    [XTrain, XTest, YTrain, YTest] = load_MNIST();
    kvec = [20, 50, 100, 150, 200, 250];
    split_vals = 100;
  elseif strcmp(data_name, 'gisette')
    data_pos = 2;
    [XTrain, XTest, YTrain, YTest] = load_gisette();
    %kvec = [10, 20, 30, 40, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500];    
    %kvec = [10, 20, 30, 40, 50, 100, 150, 200, 250, 300, 350, 400];    
    kvec = [10:10:100];   % Vectorizing this is not really that efficient sadly. 
    split_vals = 250;
  elseif strcmp(data_name, 'arcene')
    data_pos = 3;
    [XTrain, XTest, YTrain, YTest] = load_arcene();
    % really only see difference from 10 to 100 so
    kvec = [2:2:100];
    %kvec = [2:2:100,150, 200, 250, 300, 350, 400, 450, 500, 600, 700, 800, 900, 1000];
    split_vals = 100;
    %kvec = [10, 20, 30, 40, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500, 600, 700, 800, 900, 1000];
    %kvec = [10, 20, 30, 40, 50, 100, 150, 200, 250, 300, 350, 400];
  elseif strcmp(data_name, 'colon')
    data_pos = 4;
    [XTrain, XTest, YTrain, YTest] = load_colon();    
    kvec = [2:2:100];
    split_vals = 62;
  end
  
  % Data should always be centered (makes no diff for NN, but may for random projections)
  [ XTrain, XTest ] = center_two_matrices( XTrain, XTest);

  if is_norm
    XTrain = normalize_matrix_obs(XTrain);
    XTest = normalize_matrix_obs(XTest);
  end

  XTrainNorm = compute_generic_all_norm( XTrain, false);
  XTestNorm = compute_generic_all_norm( XTest, false);

  % Compute actual accuracy here

  true_par = update_basic_knn_csvs_for_actual_nn(XTrain, XTest, YTrain, YTest, nn_comparison, data_pos, num_neigh, BASIC_KNN_CSV_NAME, true);

end
