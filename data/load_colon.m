function [XTrain, XTest, YTrain, YTest] = load_colon()
  
  ColonData = feval('load', 'colon.csv');
  % Divide Colon based on rng(10)
  idx = [13,2,39,10,35,52,37,22,54,50,9,7,43,6,60,18,47,36,34,49,45,23,55,51,26,25,58,5,14,28,32,21,41,61,30,16,27,40,3,29,24,11,20,17,4,46,8,1,31,15,42,53,59,38,44,48,62,33,19,56,12,57];
  
  XTrain = ColonData(idx(1:31),1:2000);
  YTrain = ColonData(idx(1:31),2001);

  XTest = ColonData(idx(32:62),1:2000);
  YTest = ColonData(idx(32:62),2001);

end
