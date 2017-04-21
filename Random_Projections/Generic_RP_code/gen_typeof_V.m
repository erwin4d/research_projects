function [ V ] = gen_typeof_V(X, k, option, opt_para )

  % For cases when we want to do generic random projections
  % i.e. V = 1/sqrt(k) XR
  
  % However, in this code we do not compute 1/sqrt(k), since
  % we usually use V to find norms, ED, IP

  % Scaling factor can always be factored out

  % More appropriately, we're computing V = XR here
  
  % option and opt_para are passed into gen_typeof_R (see function desc for more info)

  % Get num_paras (cols) of X
  [ ~, p] = size(X);
  R = gen_typeof_R( p, k, option, opt_para);
  V = X * R; % again, remember no scaling parameter

end

