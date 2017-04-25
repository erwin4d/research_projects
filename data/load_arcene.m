function [XTrain, XTest, YTrain, YTest] = load_arcene()

  XTrain = sparse(feval('load', 'arcene_train.data'));
  YTrain = feval('load', 'arcene_train.labels');
  XTest = sparse(feval('load', 'arcene_valid.data'));
  YTest = feval('load', 'arcene_valid.labels');

end
