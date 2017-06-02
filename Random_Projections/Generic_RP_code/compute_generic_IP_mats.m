function [ IP ] = compute_generic_IP_mats( mat1, mat2, is_est, varargin)
  
  p = inputParser;  
  p.addRequired('mat1',@(x) true);
  p.addRequired('mat2',@(x) true);
  p.addRequired('is_est',@islogical);
  p.addOptional('option', 'none', @(x) any(strcmp(x,{'normal', 'binary', 'SB', 'SRHT'})));
  p.addOptional('opt_para', -1, @(x) true);
  p.addOptional('is_sim', false, @islogical);
  p.addOptional('kvec', 1, @(x) true);
  p.parse(mat1, mat2, is_est,varargin{:});
  inputs = p.Results;

  % Setup: Random projections, where we have V1 = X1R ; V2 = X2R
  % This function computes the actual IP between the two matrices, row by row
  % or an estimated IP between two matrices

  % mat1, mat2: 
  % is_est : false   - compute actual IP using X1, X2 as input
  %          true  - compute estimated IP using V1, V2 using V as input

  % Optional parameters
  % option: type of random projection matrix
  % opt_para: scaling factor for sparse bernoulli option
  % is_sim: boolean ; true if computing vectors of IP for subset of K cols for simulations
  %                   false - return just estimated IP using K cols
  % kvec:   subset of K cols

  if ~is_est 
  	% Compute IP of mat. Is exact estimate
  	IP = sum((mat1.*mat2),2);
  else
    % Compute inner product given V
    % Note that we didn't include scaling factor in our previous functions
    % so we're putting them in now.
    % See derviations.pdf 
    if inputs.is_sim
      IP = cumsum((mat1.*mat2),2);
      IP = IP(inputs.kvec) ./ inputs.kvec;
    else
      IP = mean(mat1.*mat2,2);
    end
    if strcmp(inputs.option, 'SB') 
      IP = inputs.opt_para * IP;
    end
  end


end

