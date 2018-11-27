function [ X_struct ] = build_X_struct(X, iscent, isnormalized)
  
  % In general, we center first before normalizing

  if iscent
  	X = center_matrix(X);
  	X_struct.is_cent = true;
  else
    X_struct.is_cent = false;
  end

  if isnormalized
  	X = normalize_matrix_obs(X);
  	X_struct.is_normalized = true;
  else
    X_struct.is_normalized = false;
  end

  X_struct.mat = X;
  X_struct.num_obs = size(X,1);
  X_struct.num_p = size(X,2);
  X_struct.total_pairwise = nchoosek(size(X,1), 2);

  


end

