function [ IP ] = compute_generic_IP_mats( mat1, mat2, varargin)
  
  p = inputParser;  
  p.addRequired('mat1',@(x) true);
  p.addRequired('mat2',@(x) true);
  p.addOptional('is_sim', false, @islogical);
  p.addOptional('kvec', 1, @(x) true);
  p.parse(mat1, mat2,varargin{:});
  inputs = p.Results;

  % Setup: Random projections, where we have V1 = X1R ; V2 = X2R
  % This function computes the actual IP between the two matrices, row by row
  % or an estimated IP between two matrices

  % mat1, mat2: 

  % Optional parameters
  % is_sim: boolean ; true if computing vectors of IP for subset of K cols for simulations
  %                   false - return just estimated IP using K cols
  % kvec:   subset of K cols

  if isfield(mat1,'vmat') == 0 || isfield(mat2,'vmat') == 0
  	% Compute IP of mat. Is exact estimate
  	IP = sum((mat1.*mat2),2);
  else
    if mat1.signature ~= mat2.signature
      'The matrices are not formed from the same random matrix!'
      return
    end
    % Compute inner product given V
    % Note that we didn't include scaling factor in our previous functions
    % so we're putting them in now.
    % See derviations.pdf 
    vmat1 = mat1.vmat;
    vmat2 = mat2.vmat;

    if inputs.is_sim
      IP = cumsum((vmat1.*vmat2),2);
      IP = IP(inputs.kvec) ./ inputs.kvec;
    else
      IP = mean(vmat1.*vmat2,2);
    end
    IP = mat1.scaling_factor * IP;
  end


end

