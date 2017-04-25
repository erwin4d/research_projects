function [ true_par ] = update_basic_knn_csvs_for_actual_nn(XTrain, XTest, YTrain, YTest, nn_mat, data_pos, neighbor_pos, text_save_name)

  % Updates csv files if needed
  
  true_par = nn_mat(neighbor_pos, data_pos);

  if true_par == 0
    labels  = basic_KNN( XTrain, XTest, YTrain, 'k', neighbor_pos);
    true_par = sum(labels == YTest)/size(YTest,1);
    nn_mat(neighbor_pos, data_pos) = true_par;
    csvwrite(text_save_name, nn_mat);      
  end
  
end