function [ests] = get_V_ests_all(currV, varargin)

  % Get true pairwise values of data matrix X
  p = inputParser;  
  p.addRequired('currV',@(x) true);
  p.addOptional('mul', false, @islogical); % TBU
  p.parse(currV, varargin{:});
  inputs = p.Results;

  n1 = size(currV.V1,1);
  n2 = size(currV.V2,1);

  ests.v1norm = repmat(sum(currV.V1.^2,2) * currV.scale ,1,n2);
  ests.v2norm = repmat(sum(currV.V2.^2,2)' * currV.scale,n1,1);
  ests.v1v2 = currV.V1 * currV.V2' * currV.scale;

  ests.n1 = n1;
  ests.n2 = n2;
end
      
  