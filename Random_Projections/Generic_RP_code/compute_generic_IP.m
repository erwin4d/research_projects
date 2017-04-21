function [ IP ] = compute_generic_IP(  row1, row2, mat, is_est, option, opt_para, is_sim )

  % Compute the inner product between any two rows of X
  % or the estimated inner product between any two rows of V := XR
  % as a vector of increasing k 

  % For example, if V was n by k, we want to know how accurate our
  % estimates are...
  
  % is_est: can either be true (estimating IP given V)
  %                   or false (exact IP given V)

  % mat:    either true X, or estimated V

  % option   : both used only if is_est is true, and corresponds
  % opt_para : to the option , opt_para in gen_typeof_R
  % is_sim: If we want to simulate and look at the estimates with increasing columns k, can compute estimates all at once

 
  if ~is_est
  	% Compute IP of mat. Is exact estimate
  	IP = mat(row1,:) * mat(row2,:)';
  else
    % Compute inner product given V
    % Note that we didn't include scaling factor in our previous functions
    % so we're putting them in now.
    % See derviations.pdf 
    [ ~, k ] = size(mat);
    if is_sim
      IP = cumsum( (mat(row1,:) .* mat(row2,:))) ./ (1:k);
    else
      IP = mean( (mat(row1,:) .* mat(row2,:)));
    end
    if strcmp(option, 'SB')
      IP = opt_para * IP;
    end
    IP = (IP);
  end

end

