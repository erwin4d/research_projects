function [XTrain, XTest, YTrain, YTest] = load_gisette()

  XTrain = sparse(feval('load', 'gisette_train.data'));
  YTrain = feval('load', 'gisette_train.labels');
  XTest = sparse(feval('load', 'gisette_valid.data'));
  YTest = feval('load', 'gisette_valid.labels');

end
