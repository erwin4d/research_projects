function [ X_cent ] = center_matrix( X )
  
  X_cent = X - repmat(mean(X,1), size(X,1), 1);


end

