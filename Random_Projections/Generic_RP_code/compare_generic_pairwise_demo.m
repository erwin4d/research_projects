function [rmse_vec ] = compare_generic_pairwise_demo(X, niter, varargin)

  % Look at the average RMSE for pairwise <quantity> over entire dataset X
  % use random projection matrix of columns K = 2, 3, ... 100

  % Inputs
  %            X: dataset
  %        niter: number of iterations
  %       option: type of random proj matrix
  %     opt_para: optional para for above random projection matrix
  %     pairwise: type of pairwise estimate needed
  %    partition: for computing true values - partition the x and y (vectorization / memory tradeoff)

  % Example inputs
  % compare_generic_pairwise_demo(X, 1000, 'option', 'normal', 'opt_para', -1, 'pairwise', 'inner product', 'partition', 250)

  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Defining parameters given inputs
  %
  p = inputParser;  
  p.addRequired('X',@(x) true);
  p.addRequired('niter',@(x) x > 0);
  p.addOptional('option', 'none', @(x) any(strcmp(x,{'normal', 'binary', 'SB'})));
  p.addOptional('opt_para', -1, @(x) true);
  p.addOptional('pairwise', 'none', @(x) any(strcmp(x,{'squared euclidean distance', 'inner product'})));
  p.addOptional('partition', -1, @(x) true); 
  %
  p.parse(X, niter,varargin{:});
  inputs = p.Results;
  option = inputs.option;
  pairwise = inputs.pairwise;
  opt_para = inputs.opt_para;
  %
  disp(['Computing estimates of ', pairwise])
  %
  if inputs.partition == -1
    partition = min(size(X,1), 250); % Default 250 by 250 
  else
    partition = inputs.partition;
  end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Build up para structure
  kvec = 2:100;
  rmse_vec = zeros(niter,length(kvec));
  X = normalize_matrix_obs(X); % normalize to have length 1 for standardized comparison of RMSE

  para.N = size(X,1);  
  para.p = size(X,2);
  % Get partitions, true_vals, and total_number
  para = get_partitions_for_data(para, partition, kvec) ;
  para = get_true_vals_all(X, para, pairwise);
  para.tot_num = (para.N*(para.N-1))/2;
    
  figure;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Start our experiment here
  for iter_num = 1:niter;
    
    % Generate everything at once, store what is needed
    V = gen_typeof_V(X, max(kvec), 'option', option, 'opt_para', opt_para);
    currV.scaling_factor = V.scaling_factor;

    % Now look within segment
    for xseg = 1:length(para.partition_start)
      disp(['iter_num is ', num2str(iter_num)  '  xseg is ', num2str(xseg)])
      currV.V1 =  V.vmat(para.partition_start(xseg):para.partition_end(xseg),:);
      for yseg = xseg:length(para.partition_start)
        currV.V2 =  V.vmat(para.partition_start(yseg):para.partition_end(yseg),:);

        % Define what we need to compute in variable ests.
        % All we want is just pairwise estimates of either euclidean distance or inner product

        ests.pairwise_dist = zeros(length(para.partition_start(xseg):para.partition_end(xseg)), length(para.partition_start(yseg):para.partition_end(yseg)), size(para.kidx,1));

        % Now, compute each individual parts. 
        for kvals = 1:length(kvec)
          currV = get_V_mats_given_k(currV, para, kvals);
          ests = get_V_ests_generic(currV, ests, pairwise, kvals);
        end
        
        ests.pairwise_dist = cumsum(ests.pairwise_dist,3);         

        for kvals = 1:length(kvec)
          % Now, record each estimate
          ests.small_pairwise_distance = (ests.pairwise_dist(:,:,kvals)) * currV.scaling_factor / kvec(kvals);
          rmse_vec(iter_num,kvals) = rmse_vec(iter_num,kvals) + get_rmse_all(ests.small_pairwise_distance, para, xseg, yseg);

        end
      end
    end
    for kvals = 1:length(kvec)  
      rmse_vec(iter_num,kvals) = sqrt(rmse_vec(iter_num,kvals) / para.tot_num);
    end

    if mod(iter_num, 10) == 0
      clf('reset');
      local_plot(kvec, rmse_vec, iter_num, false, pairwise)
      drawnow
    end
  end

  

end



function [ ] = local_plot(kvec, rmse, iter_num, fig_para, pairwise)

  if fig_para
    figure;
  end
  
  plot_avg_sd_expts(kvec, rmse, iter_num, 'Pairwise estimate', 'b')
  grid on;  

  title(['Average RMSE of pairwise ', pairwise, ' at ', num2str(iter_num), ' iterations'], 'FontWeight', 'bold');
  xlabel('Number of columns K', 'FontWeight', 'bold');
  legend('-DynamicLegend', 'location', 'northeast');
  ylabel('Average RMSE', 'FontWeight', 'bold');



end



