function [para] = get_true_vals_all(X, para, typeof)

  % Get true pairwise values of data matrix X
  % Choice of:
  %    - squared euclidean distance
  %    - inner product
  %    - resemblance (assume binary vectors)
  %    - angle

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
      truevals(xidx_start(xseg):xidx_end(xseg), xidx_start(yseg):xidx_end(yseg)) = local_true_vals(curr_X1, curr_X2, typeof, (xidx_end(yseg) - xidx_start(yseg)) + 1 , (xidx_end(xseg) - xidx_start(xseg) +1) );
    end
  end


  para.true_val = triu(truevals,1);


end



function [val] = local_true_vals(X1, X2, typeof, n1col, n2row)

  if strcmp(typeof, 'angle')
    val = local_get_angle(X1,x2);
  elseif strcmp(typeof, 'squared euclidean distance')
    val = local_get_euclidean_dist(X1,X2, n1col, n2row);
  elseif strcmp(typeof, 'inner product')
    val = local_get_inner_prod(X1,X2);
  elseif strcmp(typeof, 'resemblance')
    val = local_get_resemblance(X1,X2, n1col, n2row);
  else
    disp(['Error!'])
    return;
  end

end




function [val] = local_get_angle(X1,X2)
  val = acos(X1 * X2');
end




function [val] = local_get_inner_prod(X1,X2)

  val = X1 * X2';

end

function [val] = local_get_euclidean_dist(X1,X2, n1col, n2row)

  norm_X1 = repmat(sum(X1.^2,2),1,n1col);
  norm_X2 = repmat(sum(X2.^2,2)',n2row,1);
  XY = X1 * X2';

  val = (norm_X1 + norm_X2 - 2*XY);

end


function [val] = local_get_resemblance(X1,X2, n1col, n2row)
  
  % Convert them to binary ; ASSUMPTION all positive
  X1 = sign(X1);
  X2 = sign(X2);

  norm_X1 = repmat(sum(X1.^2,2),1,n1col);
  norm_X2 = repmat(sum(X2.^2,2)',n2row,1);
  XY = X1 * X2';

  val = XY ./ (norm_X1 + norm_X2 - XY);

end
  