function [ norm_val ] = compute_generic_norm( row, mat, is_est, option, opt_para, is_sim)

  % Compute the norm of a row of X
  % or the estimated norm of a row of V := XR
  % as a vector of increasing k 

  % For example, if V was n by k, we want to know how accurate our
  % estimates are...
  
  % is_est: can either be true (estimating norm given V)
  %                   or false (exact norm given V)

  % mat:    either true X, or estimated V

  % option   : both used only if is_est is true, and corresponds
  % opt_para : to the option , opt_para in gen_typeof_R
  % is_sim: If we want to simulate and look at the estimates with increasing columns k, can compute estimates all at once


  if is_est == false
  	% Compute norm of row of mat. Is exact estimate
  	norm_val = norm(mat(row,:));
  else
    % Compute norm given V
    % Note that we didn't include scaling factor in our previous functions
    % so we're putting them in now.
    % See derviations.pdf 
    [ ~, k ] = size(mat);
    if strcmp(is_sim, 'yes')
      norm_val = cumsum((mat(row,:)).^2) ./ (1:k);
    else
      norm_val = mean( (mat(row,:)).^2);
    end
    if option == 4
      norm_val = opt_para * norm_val;
    end
    norm_val = sqrt(norm_val);
  end


end

