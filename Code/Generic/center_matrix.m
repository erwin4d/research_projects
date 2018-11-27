function [ X_cent ] = center_matrix( X )
  
  X_cent = bsxfun(@minus,X,mean(X,1));


end

