function [ ED ] = compute_generic_ED( row1, row2, mat, is_est, varargin)
  
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
  % This function computes the actual ED between two rows of X
  % or an estimated ED between two rows of X using V

  % mat: X (or V)
  % is_est : false   - compute actual ED using X as input
  %          true  - compute estimated ED using V using V as input

  % Optional parameters
  % option: type of random projection matrix
  % opt_para: scaling factor for sparse bernoulli option
  % is_sim: boolean ; true if computing vectors of ED for subset of K cols for simulations
  %                   false - return just estimated ED using K cols
  % kvec:   subset of K cols

  if ~is_est 
  	% Compute ED of mat. Is exact estimate
  	ED = norm(mat(row1,:) - mat(row2,:));
  else
    % Compute Euclidean distance given V
    % Note that we didn't include scaling factor in our previous functions
    % so we're putting them in now.
    % See derviations.pdf 
    [ ~, k ] = size(mat);
    if inputs.is_sim
      ED = cumsum((mat(row1,:) - mat(row2,:)).^2);
      ED = ED(inputs.kvec) ./ inputs.kvec;
    else
      ED = mean((mat(row1,:) - mat(row2,:)).^2);
    end
    if strcmp(inputs.option, 'SB') 
      ED = inputs.opt_para * ED;
    end
    ED = sqrt(ED);
  end


end

