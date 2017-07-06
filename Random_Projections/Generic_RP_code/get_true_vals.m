function [truevals] = get_true_vals(X, para, typeof)

  % Get true pairwise values of data matrix X
  % Pairwise values currently can be: Euclidean distances, inner products

  % para contains the partition, in case matrix X is
  % too big to vectorize all at once.
  
  
  % Note there is some double counting (symmetric matrix), but this is faster than
  % writing more loops.

  % This assumes that the n by n matrix can be stored in memory.

  n = para.N;
  xidx_start = para.partition_start;
  xidx_end = para.partition_end;


  truevals = zeros(n,n); % Note: this again assumes Matlab can store this in memory.


  for xseg = 1:length(xidx_start)
    curr_X1 = X(xidx_start(xseg):xidx_end(xseg),:);
    for yseg = xseg:length(xidx_start)
      curr_X2 = X(xidx_start(yseg):xidx_end(yseg),:);
      if strcmp(typeof, 'squared_euclidean_distance')
        % x^2 - 2xy + y^2
        norm_X1 = repmat(sum(curr_X1.^2,2),1,(xidx_end(yseg) - xidx_start(yseg) +1));
        norm_X2 = repmat(sum(curr_X2.^2,2)',(xidx_end(xseg) - xidx_start(xseg) +1),1);
        XY = curr_X1 * curr_X2';

        truevals(xidx_start(xseg):xidx_end(xseg), xidx_start(yseg):xidx_end(yseg)) = (norm_X1 + norm_X2 - 2*XY);

      elseif strcmp(typeof, 'inner_product')
        truevals(xidx_start(xseg):xidx_end(xseg), xidx_start(yseg):xidx_end(yseg)) = curr_X1 * curr_X2';
      end
    end
  end
end
      
  