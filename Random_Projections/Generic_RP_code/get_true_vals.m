function [truevals] = get_true_vals(X, partition_x, partition_y, typeof)

  % Get true pairwise values of data matrix X
  % Pairwise values currently can be: Euclidean distances, inner products

  % partition_x, partition_y are to partition the matrix X if it is
  % too big to vectorize all at once.
  % Generally, partition_x could be equal to partition y
  
  % Note there is double counting (symmetric matrix), but this is faster than
  % writing more loops.

  % This assumes that the n by n matrix can be stored in memory.

  n = size(X,1);

  xidx_start = 1:partition_x:n;
  xidx_end = partition_x:partition_x:n;

  yidx_start = 1:partition_y:n;
  yidx_end = partition_y:partition_y:n;
  
  if(xidx_end(end)) ~= n
    xidx_end = [xidx_end, n];
  end

  if(yidx_end(end)) ~= n
    yidx_end = [yidx_end, n];
  end

  truevals = zeros(n,n); % Note: this again assumes Matlab can store this in memory.

  for xseg = 1:length(xidx_start)
    curr_X1 = X(xidx_start(xseg):xidx_end(xseg),:);
    for yseg = 1:length(yidx_start)
      curr_X2 = X(yidx_start(yseg):yidx_end(yseg),:);
      if strcmp(typeof, 'squared_euclidean_distance')
        % x^2 - 2xy + y^2
        norm_X1 = repmat(sum(curr_X1.^2,2),1,(yidx_end(yseg) - yidx_start(yseg) +1));
        norm_X2 = repmat(sum(curr_X2.^2,2)',(xidx_end(xseg) - xidx_start(xseg) +1),1);
        XY = curr_X1 * curr_X2';

        truevals(xidx_start(xseg):xidx_end(xseg), yidx_start(yseg):yidx_end(yseg)) = (norm_X1 + norm_X2 - 2*XY);

      elseif strcmp(typeof, 'inner_product')
        truevals(xidx_start(xseg):xidx_end(xseg), yidx_start(yseg):yidx_end(yseg)) = curr_X1 * curr_X2';
      end
    end
  end
end
      
  