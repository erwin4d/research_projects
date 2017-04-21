function [ ED ] = compute_generic_ED( row1, row2, mat, is_est, option, opt_para, is_sim)
  
  % Compute the Euclidean distance between any two rows of X
  % or the estimated Euclidean distance between any two rows of V := XR
  % as a vector of increasing k 

  % For example, if V was n by k, we want to know how accurate our
  % estimates are...
  
  % is_est: can either be true (estimating ED given V)
  %                   or false (exact ED given V)

  % mat:    either true X, or estimated V

  % option   : both used only if is_est is true, and corresponds
  % opt_para : to the option , opt_para in gen_typeof_R
  % is_sim: If we want to simulate and look at the estimates with increasing columns k, can compute estimates all at once
 
  if ~is_est 
  	% Compute ED of mat. Is exact estimate
  	ED = norm(mat(row1,:) - mat(row2,:));
  else
    % Compute Euclidean distance given V
    % Note that we didn't include scaling factor in our previous functions
    % so we're putting them in now.
    % See derviations.pdf 
    [ ~, k ] = size(mat);
    if is_sim
      ED = cumsum((mat(row1,:) - mat(row2,:)).^2) ./ (1:k);
    else
      ED = mean((mat(row1,:) - mat(row2,:)).^2);
    end
    if strcmp(option, 'SB') 
      ED = opt_para * ED;
    end
    ED = sqrt(ED);
  end


end

