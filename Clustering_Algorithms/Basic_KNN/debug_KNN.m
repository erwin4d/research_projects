function [ VXTrain, VXTest ] = debug_KNN( VXTrain, VXTest, k)

  % Don't use this in simulations as it is costly!
  % Puts the scaling factor into random matrices, makes it easier to debug
  % (Not really needed since x :->x^2 is monotonic)
  % Assume both matrices same cols
   
  VXTrain = VXTrain ./ sqrt(k); % ugh
  VXTest = VXTest ./ sqrt(k); % ugh

end

