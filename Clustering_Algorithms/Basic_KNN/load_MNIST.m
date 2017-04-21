function [XTrain, XTest, YTrain, YTest] = load_MNIST()

  % Load MNIST data

  XTrain = sparse(transpose(loadMNISTImages('train-images-idx3-ubyte')));
  YTrain = (loadMNISTLabels('train-labels-idx1-ubyte'));

  XTest = sparse(transpose(loadMNISTImages('t10k-images-idx3-ubyte')));
  YTest = (loadMNISTLabels('t10k-labels-idx1-ubyte'));


end
