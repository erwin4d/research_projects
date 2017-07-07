function [ests] = get_V_ests_all(currV, varargin)

  % Get true pairwise values of data matrix X
  p = inputParser;  
  p.addRequired('currV',@(x) true);
  p.addOptional('bivar_euc_theo', false, @islogical); % TBU
  p.addOptional('bivar_ips_theo', false, @islogical); % TBU
  p.parse(currV, varargin{:});
  inputs = p.Results;

  n1 = size(currV.V1,1);
  n2 = size(currV.V2,1);

  ests.v1norm = repmat(sum(currV.V1.^2,2) * currV.scale ,1,n2);
  ests.v2norm = repmat(sum(currV.V2.^2,2)' * currV.scale,n1,1);
  ests.v1v2 = currV.V1 * currV.V2' * currV.scale;

  ests.n1 = n1;
  ests.n2 = n2;

  if inputs.bivar_euc_theo == true
    v1_norm_four = repmat(sum(currV.V1.^4,2), 1, n2);
    v2_norm_four = repmat(sum(currV.V2.^4,2)', n1, 1);
    
    cov_numer1 = v1_norm_four + v2_norm_four + 2*currV.V1.^2 * currV.V2.^2' - 2*currV.V1.^3*currV.V2' - 2*currV.V1 * currV.V2.^3' -  ((ests.v2norm + ests.v1norm) .* ((ests.v2norm + ests.v1norm) - 2*ests.v1v2))/ currV.scale;
    cov_denom1 = v1_norm_four + v2_norm_four +  2 * currV.V1.^2 * currV.V2.^2' - (ests.v2norm + ests.v1norm).^2 / currV.scale;

    mvn2d_c_hat = cov_numer1./cov_denom1;
    mvn2d_c_hat(1:(length(mvn2d_c_hat)+1):end) = 0;
    ests.mvn2d_est = ests.v1norm + ests.v1norm - 2*ests.v1v2 - mvn2d_c_hat .* (ests.v1norm + ests.v2norm - 2);    
  end

  if inputs.bivar_ips_theo == true
    v1_norm_four = repmat(sum(currV.V1.^4,2), 1, n2);
    v2_norm_four = repmat(sum(currV.V2.^4,2)', n1, 1);
    

    cov_numer1 = currV.V1.^3 * currV.V2' + currV.V1 * currV.V2.^3' - (ests.v2norm + ests.v1norm) .* ests.v1v2 / currV.scale; % this is 

    cov_denom1 = v1_norm_four + v2_norm_four +  2 * currV.V1.^2 * currV.V2.^2' - (ests.v2norm + ests.v1norm).^2 / currV.scale;

    mvn2d_c_hat = cov_numer1./cov_denom1;
    mvn2d_c_hat(1:(length(mvn2d_c_hat)+1):end) = 0;
    ests.mvn2d_est = ests.v1v2 - mvn2d_c_hat .* (ests.v1norm + ests.v2norm - 2);   

  end

end
