function [XPair1, XPair2, normPair1, normPair2 ] = prepare_correct_idx_for_rpcv_sims(X, data_name, idx1, idx2, idx_file, file_name, sim_type, is_norm)


  X = center_matrix(X);  
  % Means we didn't prepare indexes, so let's do so and save it in our file
  if sum(idx_file(:,idx1) == 0) > 0 || sum(idx_file(:,idx2) == 0) > 0
    % Let's center the data

    if is_norm
    	X = normalize_matrix_obs(X);
    end

    len_X = size(X,1);
    
    if strcmp(sim_type, 'ED')
      % Suppose we want to compute pairwise Euclidean distance between vector.
      cmp_mat = sqrt(abs(repmat(sum(X.^2,2),1, len_X) + (repmat(sum(X.^2,2),1,len_X))' - 2 * X*X'));
    elseif strcmp(sim_type, 'IP')
      cmp_mat = abs(X*X');    	
    end
    
    % Pick percentiles
    [sorted_vec, sort_idx] = sort(reshape(cmp_mat.',1,[]));
    % Is zero?
    len_min = length(sorted_vec(sorted_vec == min(sorted_vec)));
    % start from len_min + 1 
    len_max = length(sorted_vec(sorted_vec == max(sorted_vec)));

    mod_sort_idx = sort_idx((len_min+1):(length(sort_idx)-len_max));
    pectiles_a = sort_idx(1:floor(length(mod_sort_idx)/10):length(mod_sort_idx));
    pectiles_b = sort_idx(1:floor(length(mod_sort_idx)/11):length(mod_sort_idx));
    
    if length(pectiles_a) == 11
    	pectiles = pectiles_a;
    elseif length(pectiles_b) == 11
    	pectiles = pectiles_b;
    else
    	pectiles = pectiles_b(1:11);
    end


    new_idx1 = floor(pectiles/len_X) + 1;
    new_idx2 = pectiles - ((new_idx1-1) * len_X);
    check_this = new_idx2(new_idx2 == 0);
    if length(check_this) > 0;
    	new_idx2(new_idx2 == 0) = len_X;
    	new_idx1(new_idx1 == 0) = new_idx1(new_idx1 == 0) - 1;
    end
    XPair1 = X(new_idx1,:);
    XPair2 = X(new_idx2,:);
    idx_file(:,idx1) = new_idx1';
    idx_file(:,idx2) = new_idx2';
    csvwrite(file_name, idx_file);  
  else
    XPair1 = X(idx_file(:,idx1),:);
    XPair2 = X(idx_file(:,idx2),:);
    if is_norm
    	XPair1 = normalize_matrix_obs(XPair1);
    	XPair2 = normalize_matrix_obs(XPair2);
    end
  end
  
  normPair1 = (compute_generic_all_norm(XPair1, false)).^2;
  normPair2 = (compute_generic_all_norm(XPair2, false)).^2;


end