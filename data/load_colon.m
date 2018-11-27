function [X, Y] = load_colon()
  
  ColonData = feval('load', 'colon.csv');
  % Divide Colon based on rng(10)
  X = ColonData(:,1:2000);
  Y = ColonData(:,2001);  

end
