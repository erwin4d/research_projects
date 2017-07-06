function [truevals] = get_V_ests_generic(currV, typeof)

  % Get true pairwise values of data matrix X
  % Pairwise values currently can be: Euclidean distances, inner products
  n1 = size(currV.V1,1);
  n2 = size(currV.V2,1);

  if strcmp(typeof, 'squared_euclidean_distance')
    % x^2 - 2xy + y^2
    norm_X1 = repmat(sum(currV.V1.^2,2) * currV.scale ,1,n2);
    norm_X2 = repmat(sum(currV.V2.^2,2)' * currV.scale,n1,1);
    XY = currV.V1 * currV.V2' * currV.scale;

    truevals = (norm_X1 + norm_X2 - 2*XY);

  elseif strcmp(typeof, 'inner_product')
    truevals = (currV.V1 * currV.V2' * currV.scale);
  end

end
      
  