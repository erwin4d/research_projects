function [ mat ] = convert_vec_to_upper_triangular( vec )
  
  % Convert a vector to an upper triangular matrix
  % Assume vector is of size S_n, where S_1 = 1, S_2 = 1+2, S_3 = 1+2+3 ...

  % This is taken from Jan's answer at https://www.mathworks.com/matlabcentral/answers/350413-put-elements-into-corresponding-locations-of-upper-triangular-matrix
  
  % find size of matrix
  n = round((sqrt(8 * numel(vec) + 1) - 1) / 2);
  
  mat = zeros(n+1,n+1);
  mat(triu(true(n+1),1)) = vec;

end

