function [X] = expand_word_matrix(data_name)
  
  
  % Normalize, get the evec and shit

  if strcmp(data_name, 'kos')
    % Load words data
    X = load('docword.kos.txt');
  elseif strcmp(data_name, 'nips')
    X = load('docword.nips.txt');
  end
  
  % Expand X - log term weighting
  X = sparse(X(:,1), X(:,2), 1+log(X(:,3)));
  X = normalize_matrix_obs(X);

end



  

 
 

    