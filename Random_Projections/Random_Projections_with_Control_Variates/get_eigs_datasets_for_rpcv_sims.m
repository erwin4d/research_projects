function [vecs] = get_eigs_datasets_for_rpcv_sims(data_name, num_eigs)
  
  % Perfect, let's load our datasets!
  if strcmp(data_name, 'colon')
    % Load colon data
    [XTrain, XTest, ~, ~] = load_colon();    
    X = [XTrain;XTest]; % Put them together since we're interested in all ED / IP
  elseif strcmp(data_name, 'kos')
  	% Load kos data
  	X = load_kos();
  elseif strcmp(data_name, 'arcene')
  	X = load_arcene_conso();
  elseif strcmp(data_name, 'nips')
  	X = load_nips();
  end

  X = center_matrix(X);  
  [vecs,~] = eigs(cov(X), num_eigs);
  vecs = vecs';

end