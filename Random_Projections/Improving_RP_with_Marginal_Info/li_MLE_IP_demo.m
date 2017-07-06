function [ ] = li_MLE_IP_demo(X, niter, varargin)

  % Look at the average RMSE for pairwise <quantity> over entire dataset X
  % use random projection matrix of columns K = 10,20, ... 100 using
  % li's method

  % Inputs
  %            X: dataset
  %        niter: number of iterations
  %       option: type of random proj matrix
  %     opt_para: optional para for above random projection matrix
  %     pairwise: type of pairwise estimate needed
  %  partition_x: for computing true values - partition the x (vectorization / memory tradeoff)
  %  partition_y: for computing true values - partition the y (vectorization / memory tradeoff)

  % Example inputs
  % li_MLE_IP_demo(X, 1000, 'option', 'normal', 'opt_para', -1, 'partition_x', 250, 'partition_y', 250)

  
  
  p = inputParser;  
  p.addRequired('X',@(x) true);
  p.addRequired('niter',@(x) x > 0);
  p.addOptional('option', 'none', @(x) any(strcmp(x,{'normal', 'binary', 'SB'})));
  p.addOptional('opt_para', -1, @(x) true);
  p.addOptional('partition_x', -1, @(x) true); 
  p.addOptional('partition_y', -1, @(x) true); 

  p.parse(X, niter,varargin{:});
  inputs = p.Results;
  option = inputs.option;
  opt_para = inputs.opt_para;

  N = size(X,1);  
  if inputs.partition_x == -1
    partition_x = size(X,1); % Careful, will do matrix multplication on whole X
  else
    partition_x = inputs.partition_x;
  end

  if inputs.partition_y == -1
    partition_y = size(X,1); % Careful, will do matrix multplication on whole X
  else
    partition_y = inputs.partition_y;
  end


  kvec = 10:10:100;
  rmse_vec = zeros(niter,length(kvec));

  X = normalize_matrix_obs(X); % normalize to have length 1 for standardized comparison of RMSE
  
  % Get true_vals
  trueval.ip = triu(get_true_vals(X, partition_x, partition_y, 'inner_product'));



  % We don't compute the inner product I think
  tot_num = (N*(N-1))/2;

  figure;
  for iter_num = 1:niter;
    iter_num
    V = gen_typeof_V(X, max(kvec), 'option', option, 'opt_para', opt_para);
    for kvals = 1:length(kvec)
      k = kvec(kvals); 
      rmse_vec(iter_num,kvals) = get_ordinary_pairwise_rmse_for_kval(V, k, true_val, tot_num, partition_x, partition_y, pairwise);
    end
    % Plot: May want to edit plot settings for kvec starting from 10.
    %       May also want to tweak k as well.
    %       Note RMSE is independent of p! 
    if mod(iter_num, 10) == 0
      clf('reset');
      local_plot_pairwise_err(kvec, rmse_vec, pairwise, iter_num, false)
      drawnow
    end
  end




end
