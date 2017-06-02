function [ X1_cent, X2_cent ] = center_two_matrices( X1, X2)
  
  n1 = size(X1,1);

  X = center_matrix([X1;X2]);
  
  X1_cent = X(1:n1,:);
  X2_cent = X((n1+1):end,:);


end

