function [ests] = get_V_ests_generic(currV, ests, typeof, kvals)

  % Get true pairwise values of data matrix X
  % Pairwise values currently can be: Euclidean distances, inner products
  n1 = size(currV.small_V1,1);
  n2 = size(currV.small_V2,1);

  if strcmp(typeof, 'squared euclidean distance')
    % x^2 - 2xy + y^2
    norm_X1 = repmat(sum(currV.small_V1.^2,2) ,1,n2);
    norm_X2 = repmat(sum(currV.small_V2.^2,2)',n1,1);
    XY = currV.small_V1 * currV.small_V2';

    ests.pairwise_dist(:,:,kvals) = (norm_X1 + norm_X2 - 2*XY);

  elseif strcmp(typeof, 'inner product')
    ests.pairwise_dist(:,:,kvals) = (currV.small_V1 * currV.small_V2');
  end

end
      
  