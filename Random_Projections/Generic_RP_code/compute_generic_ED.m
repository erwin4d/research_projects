function [ ED ] = compute_generic_ED(mat, varargin)
  
  p = inputParser;  
  p.addRequired('mat',@(x) true);
  p.addOptional('is_sim', false, @islogical);
  p.addOptional('kvec', 1, @(x) true);
  p.parse( mat,varargin{:});
  inputs = p.Results;

  % This takes in a 2 by P matrix, where we want to find the ED between
  % the first row and second row.

  % Setup: Random projections, where we have V = XR
  % This function computes the actual ED between the two rows
  % or an estimated ED between two rows of X using V

  % mat: X (or V)

  % Optional parameters
  % is_sim: boolean ; true if computing vectors of ED for subset of K cols for simulations
  %                   false - return just estimated ED using K cols
  % kvec:   subset of K cols

  if isfield(mat,'vmat') == 0
  	% Compute ED of mat. Is exact estimate
  	ED = norm(mat(1,:) - mat(2,:));
  else
    % Compute Euclidean distance given V
    % Note that we didn't include scaling factor in our previous functions
    % so we're putting them in now.
    % See derviations.pdf 
    vmat = mat.vmat;
    [ ~, k ] = size(vmat);
    if inputs.is_sim
      ED = cumsum((vmat(1,:) - vmat(2,:)).^2);
      ED = ED(inputs.kvec) ./ inputs.kvec;
    else
      ED = mean((vmat(1,:) - vmat(2,:)).^2);
    end
    ED = mat.scaling_factor * ED;
    ED = sqrt(ED);
  end


end

