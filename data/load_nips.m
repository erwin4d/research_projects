function [X] = load_nips()
  
  % Modified NIPS:
  % Transposed the original file from UCI database, and removed 1st row / 1st col
  X = sparse(feval('load', 'modified_nips.csv'));

end

