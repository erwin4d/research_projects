function [ V ] = gen_typeof_V(X, k, varargin )

  pars = inputParser;  
  pars.addRequired('X',@(x) true);
  pars.addRequired('k',@(x) x > 0);
  pars.addOptional('option', 'none', @(x) any(strcmp(x,{'normal', 'binary', 'SB'})));
  pars.addOptional('opt_para', -1, @(x) true);
  pars.parse(X, k ,varargin{:});

  inputs = pars.Results;


  % For cases when we want to do generic random projections
  % i.e. V = 1/sqrt(k) XR

  % Example usage:
  % gen_typeof_V(X, 50, 'option', 'normal')           
  %   This computes V = XR, where R is a random matrix with iid entries N(0,1) 

  % gen_typeof_V(X, 50, 'option', 'SB', 'opt_para', 1)
  % gen_typeof_V(X, 50, 'option', 'binary')
  %   This computes V = XR, where R is a random matrix with iid binary entries

  % gen_typeof_R(X, 50, 'option', 'SB', 'opt_para', 5)
  %   This computes V = XR where R is a random matrix with i.i.d. SB(5) entries

  % We do not compute 1/sqrt(k), since we usually use V to find our estimates

  % The scaling factor can always be factored out

  % More appropriately, we're computing V = XR here
  
  % option and opt_para are passed into gen_typeof_R (see function desc for more info)

  % Get num_paras (cols) of X
  [ ~, p] = size(X);
  R = gen_typeof_R( p, k, 'option', inputs.option, 'opt_para', inputs.opt_para);
  V.vmat = X * R.rmat; % again, remember no scaling parameter
  V.rand_var = R.rand_var;
  V.scaling_factor = R.scaling_factor;
  V.signature = R.signature;
end

