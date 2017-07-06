function [ R ] = gen_typeof_R( p, k, varargin)

  pars = inputParser;  
  pars.addRequired('p',@(x) x > 0);
  pars.addRequired('k',@(x) x > 0);
  pars.addOptional('option', 'none', @(x) any(strcmp(x,{'normal', 'binary', 'SB'})));
  pars.addOptional('opt_para', -1, @(x) true);
  pars.parse(p, k ,varargin{:});

  inputs = pars.Results;

  % This generates a random projection matrix rmat of
  % dimensions p x k 

  % Example usage:
  % gen_typeof_R(200, 50, 'option', 'normal')            
  %   This generates a 200 by 50 random matrix with entries N(0,1)

  % gen_typeof_R(200, 50, 'option', 'SB', 'opt_para', 1)
  % gen_typeof_R(200, 50, 'option', 'binary')
  %   These generate a 200 by 50 random matrix with i.i.d. binary entries

  % gen_typeof_R(200, 50, 'option', 'SB', 'opt_para', 5)
  %   This generates a 200 by 50 random matrix with i.i.d. SB(5) entries


  % Return a structure with three fields
  %  rmat - the matrix
  %  rand_var - RV that generated R
  %  scaling_factor - the scaling factor needed to get other quantities
  %  signature - of this random matrix
  
  % Four possible options.  
  % opt_para differs based on option 3 and option 4 (see below)

  if strcmp(inputs.option, 'normal')
  	% Generate random projection matrix of dimensions p*k ; entries iid Normal
  	R.rmat = normrnd(0,1,p, k);
    R.rand_var = 'normal';
    R.scaling_factor = 1;
  elseif strcmp(inputs.option, 'binary')
  	% Generate random projection matrix of dimensions p*k, entries iid in {-1,1}
    R.rmat = reshape(randsample([-1,1],p*k,true,[0.5,0.5]),[p,k]);
    R.rand_var = 'binary';
    R.scaling_factor = 1;
  elseif strcmp(inputs.option, 'SB')
  	% Generate random projection matrix from Sparse Bernoulli, entries iid in {-1, 0, 1} with
  	% probability distribution 1/2s, 1-1/s, 1/s
  	% opt_para here becomes the parameter s
  	% This is slightly different from the literature where we
  	% sample -1/sqrt(s), 0, 1/sqrt(s) because the scaling factor
  	% can be factored out later
  	R.rmat = reshape(randsample([-1,0,1],p*k,true,[1/(2*inputs.opt_para),1-1/inputs.opt_para,1/(2*inputs.opt_para)]),[p,k]);
    if inputs.opt_para == 1
      R.rand_var = 'binary';
    else
      R.rand_var = 'SB';
    end
    R.scaling_factor = inputs.opt_para;
  end
  R.signature = normrnd(0,1,1,1);
end

