function [ V ] = gen_typeof_V(X, k, varargin )

  pars = inputParser;  
  pars.addRequired('X',@(x) true);
  pars.addRequired('k',@(x) x > 0);
  pars.addOptional('option', 'none', @(x) any(strcmp(x,{'normal', 'binary', 'SB', 'SRHT'})));
  pars.addOptional('opt_para', -1, @(x) true);
  pars.parse(X, k ,varargin{:});

  inputs = pars.Results;


  % For cases when we want to do generic random projections
  % i.e. V = 1/sqrt(k) XR
  
  % However, in this code we do not compute 1/sqrt(k), since
  % we usually use V to find norms, ED, IP

  % Scaling factor can always be factored out

  % More appropriately, we're computing V = XR here
  
  % option and opt_para are passed into gen_typeof_R (see function desc for more info)

  % Get num_paras (cols) of X
  [ ~, p] = size(X);
  R = gen_typeof_R( p, k, 'option', inputs.option, 'opt_para', inputs.opt_para);
  V = X * R; % again, remember no scaling parameter

end

