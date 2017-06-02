function [XPair1, XPair2, normPair1, normPair2 ] = load_datasets_for_rpcv_sims(data_name, sim_type, is_norm)
  
  DATASETS = 4;
  % namely, arcene, colon, kos, nips
  % will load CSV files to check

  if strcmp(sim_type, 'ED')
  	if is_norm
  		CSVFILENAME = 'rpcv_sims_ED_idx_norm.csv';
  	else
    	CSVFILENAME = 'rpcv_sims_ED_idx.csv';
    end
  elseif strcmp(sim_type, 'IP')
    if is_norm
    	CSVFILENAME = 'rpcv_sims_IP_idx_norm.csv';
    else
    	CSVFILENAME = 'rpcv_sims_IP_idx.csv';
    end
  end 

  idx_file = feval('load', CSVFILENAME);
  [qtile_check, num_datasets] = size(idx_file);
  if qtile_check ~= 11  % percentiles from 0, 10, 20, ... 100th ; 11 of them
    'Error'
    return
  end

  if num_datasets ~= 2*DATASETS;
    'Error'
    return
  end

  % Perfect, let's load our datasets!
  if strcmp(data_name, 'colon')
    % Load colon data
    [XTrain, XTest, ~, ~] = load_colon();    
    X = [XTrain;XTest]; % Put them together since we're interested in all ED / IP
    % Now ; subset relevant
    idx1 = 1;  % correspond to first column
    idx2 = 2;  % correspond to second columns
  elseif strcmp(data_name, 'kos')
  	% Load kos data
  	X = load_kos();
    idx1 = 3;
    idx2 = 4;
  elseif strcmp(data_name, 'arcene')
  	X = load_arcene_conso();
  	idx1 = 5;
  	idx2 = 6;
  elseif strcmp(data_name, 'nips')
  	X = load_nips();
  	idx1 = 7;
  	idx2 = 8;
  end
  
  [XPair1, XPair2, normPair1, normPair2 ] = prepare_correct_idx_for_rpcv_sims(X, data_name, idx1, idx2, idx_file, CSVFILENAME, sim_type, is_norm);


end