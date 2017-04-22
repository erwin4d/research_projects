function [ norm_val ] = compute_generic_all_norm( mat, is_est, varargin)

  p = inputParser;  
  p.addRequired('mat',@(x) true);
  p.addRequired('is_est',@islogical);
  p.addOptional('option', 'none', @(x) any(strcmp(x,{'normal', 'binary', 'SB', 'SRHT'})));
  p.addOptional('opt_para', -1, @(x) true);
  p.addOptional('is_sim', false, @islogical);
  p.addOptional('kvec', 1, @(x) true);
  p.parse(mat, is_est,varargin{:});
  inputs = p.Results;
  

  % Setup: Random projections, where we have V = XR
  % This function computes the actual vector of row norms of X
  % or an estimated vector of row norms using V

  % mat: X (or V)
  % is_est : true   - compute actual norm using X as input
  %          false  - compute estimated norms using V using V as input

  % Optional parameters
  % option: type of random projection matrix
  % opt_para: scaling factor for sparse bernoulli option
  % is_sim: boolean ; true if computing matrix of norms for subset of kvec cols for simulations
  %                   false - return just vector of row norms using K cols
  % kvec: subset for is_sim above
  if ~is_est
  	% Compute norm of row of mat. Is exact estimate
  	norm_val = sqrt(sum(mat.^2,2));
  else
    % Compute norms given V
    % Note that we didn't include scaling factor in our previous functions
    % so we're putting them in now.
    % See derviations.pdf for working
    [ ~, k ] = size(mat);
    if inputs.is_sim
      norm_val = cumsum(mat.^2,2);
      norm_val = norm_val(:,inputs.kvec) ./ inputs.kvec;
    else
      norm_val = sum(mat.^2,2)/k;
    end
    if strcmp(inputs.option, 'SB') == 1
      norm_val = inputs.opt_para * norm_val;
    end
    norm_val = sqrt(norm_val);
  end


end

