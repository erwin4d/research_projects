function [ vec ] = convert_upper_triangular_to_vec( mat )
  
  % Convert an upper triangular matrix to a vector
  vec = mat(triu(true(size(mat)), 1))';

end

