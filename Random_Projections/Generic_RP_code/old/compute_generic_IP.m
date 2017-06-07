function [ IP ] = compute_generic_IP(  row1, row2, mat, is_est, varargin )


  p = inputParser;  
  p.addRequired('row1',@(x) x > 0);
  p.addRequired('row2',@(x) x > 0);
  p.addRequired('mat',@(x) true);
  p.addRequired('is_est',@islogical);
  p.addOptional('option', 'none', @(x) any(strcmp(x,{'normal', 'binary', 'SB', 'SRHT'})));
  p.addOptional('opt_para', -1, @(x) true);
  p.addOptional('is_sim', false, @islogical);
  p.addOptional('kvec', 1, @(x) true);
  p.parse(row1, row2, mat, is_est,varargin{:});
  inputs = p.Results;

  % Setup: Random projections, where we have V = XR
  % This function computes the actual IP between two rows of X
  % or an estimated IP between two rows of X using V

  % mat: X (or V)
  % is_est : false   - compute actual IP using X as input
  %          true  - compute estimated IP using V using V as input

  % Optional parameters
  % option: type of random projection matrix
  % opt_para: scaling factor for sparse bernoulli option
  % is_sim: boolean ; true if computing vectors of IP for subset of K cols for simulations
  %                   false - return just estimated IP using K cols
  % kvec:   subset of K cols

 
  if ~is_est
  	% Compute IP of mat. Is exact estimate
  	IP = mat(row1,:) * mat(row2,:)';
  else
    % Compute inner product given V
    % Note that we didn't include scaling factor in our previous functions
    % so we're putting them in now.
    % See derviations.pdf 
    [ ~, k ] = size(mat);
    if inputs.is_sim
      IP = cumsum( (mat(row1,:) .* mat(row2,:)));
      IP = IP(inputs.kvec) ./ inputs.kvec;
    else
      IP = mean( (mat(row1,:) .* mat(row2,:)));
    end
    if strcmp(inputs.option, 'SB')
      IP = inputs.opt_para * IP;
    end
  end

end

