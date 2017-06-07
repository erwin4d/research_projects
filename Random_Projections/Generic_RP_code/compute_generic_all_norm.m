function [ norm_val ] = compute_generic_all_norm( mat, varargin)

  p = inputParser;  
  p.addRequired('mat',@(x) true);
  p.addOptional('is_sim', false, @islogical);
  p.addOptional('kvec', 1, @(x) true);
  p.parse(mat,varargin{:});
  inputs = p.Results;
  

  % Setup: Random projections, where we have V = XR
  % This function computes the actual vector of row norms of X
  % or an estimated vector of row norms using V

  % mat: X (or V)
  
  % If mat has no fields, assume we just want the norms.
  
  % Optional parameters (only if this is used for ordinary simulations)
  % Usually, want to see how well random projections do for 1 cols, 2 cols, 3 cols, ... K cols

  % is_sim: if this is set to true, we compute the norm with each increasing column number
  % kvec: subset for is_sim. For example, looking at 10 cols, 20 cols, ..

  if isfield(mat,'vmat') == 0
  	norm_val = sqrt(sum(mat.^2,2));
  else
    % Compute norms given V
    % Note that we didn't include scaling factor in our previous functions
    % so we're putting them in now.
    % See derviations.pdf for working
    vmat = mat.vmat;
    [ ~, k ] = size(vmat);
    if inputs.is_sim
      norm_val = cumsum(vmat.^2,2);
      norm_val = norm_val(:,inputs.kvec) ./ inputs.kvec;
    else
      norm_val = sum(vmat.^2,2)/k;
    end
    norm_val = mat.scaling_factor * norm_val;
    norm_val = sqrt(norm_val);
  end


end

