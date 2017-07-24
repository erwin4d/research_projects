function [XTrain, XTest, XValid, YTrain, YValid] = load_gisette()

  XTrain = sparse(feval('load', 'gisette_train.data'));
  YTrain = feval('load', 'gisette_train.labels');
  XValid = sparse(feval('load', 'gisette_valid.data'));
  YValid = feval('load', 'gisette_valid.labels');
  
  XTest = sparse(feval('load', 'gisette_test.data'));

end
