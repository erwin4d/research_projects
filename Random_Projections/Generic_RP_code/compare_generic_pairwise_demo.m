function [ ] = compare_generic_pairwise_demo(X, niter, varargin)

  % Look at the average RMSE for pairwise <quantity> over entire dataset X
  % use random projection matrix of columns K = 10,20, ... 100

  % Inputs
  %            X: dataset
  %        niter: number of iterations
  %       option: type of random proj matrix
  %     opt_para: optional para for above random projection matrix
  %     pairwise: type of pairwise estimate needed
  %  partition_x: for computing true values - partition the x (vectorization / memory tradeoff)
  %  partition_y: for computing true values - partition the y (vectorization / memory tradeoff)

  % Example inputs
  % compare_generic_pairwise_demo(X, 1000, 'option', 'normal', 'opt_para', -1, 'pairwise', 'inner_product', 'partition_x', 250, 'partition_y', 250)

  
  
  p = inputParser;  
  p.addRequired('X',@(x) true);
  p.addRequired('niter',@(x) x > 0);
  p.addOptional('option', 'none', @(x) any(strcmp(x,{'normal', 'binary', 'SB'})));
  p.addOptional('opt_para', -1, @(x) true);
  p.addOptional('pairwise', 'none', @(x) any(strcmp(x,{'squared_euclidean_distance', 'inner_product'})));
  p.addOptional('partition_x', -1, @(x) true); 
  p.addOptional('partition_y', -1, @(x) true); 

  p.parse(X, niter,varargin{:});
  inputs = p.Results;
  option = inputs.option;
  pairwise = inputs.pairwise;
  opt_para = inputs.opt_para;
  disp(['Computing estimates of ', pairwise])

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

  
  % Given a matrix X_{n x p}, compute all pairwise Euclidean distances
  % with a random projection matrix with k = 1, 2, .. 100 cols

  % Example input:

  % compare_generic_ED_demo(X, 1000, 'option', 'SB', opt_para, '5')
  % Look at RMSE of estimated norms using SB matrix of parameter 5.

  % We look at the average RMSE.
  
  kvec = 10:10:100;
  rmse_vec = zeros(niter,length(kvec));

  X = normalize_matrix_obs(X); % normalize to have length 1 for standardized comparison of RMSE
  
  % Get true_vals
  true_val = triu(get_true_vals(X, partition_x, partition_y, pairwise));
    
  tot_num = (N*(N+1))/2;

  figure;
  for iter_num = 1:niter;
    iter_num
    V = gen_typeof_V(X, max(kvec), 'option', option, 'opt_para', opt_para);
    for kvals = 1:length(kvec)
      k = kvec(kvals); 
      V_est = V.vmat(:,1:k);
      para_est = triu(get_true_vals(V_est, partition_x, partition_y, pairwise)) / k * V.scaling_factor;
      rmse_vec(iter_num,kvals) = sqrt(sum(sum( (triu(para_est) - triu(true_val)).^2))/tot_num);
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


function [ ] = local_plot_pairwise_err(kvec, rmse_vec, pairwise, iter_num, fig_para)

  if fig_para
    figure;
  end
  
  rmse_mean = mean(rmse_vec(1:iter_num,:),1);
  rmse_var = 3*sqrt(var(rmse_vec(1:iter_num,:),0,1));

  min_bound = rmse_mean - rmse_var;
  if strcmp(pairwise, 'squared_euclidean_distance')
    min_bound(min_bound < 0) = 0;
  end
  max_bound = rmse_mean + rmse_var;

  plot(kvec,rmse_mean, '-r', 'DisplayName', ['Average RMSE for ', pairwise]); hold all
  plot(kvec,min_bound, '--b', 'DisplayName', 'Lower 3sd bound'); 
  plot(kvec,max_bound, '--b', 'DisplayName', 'Upper 3sd bound'); 

  grid on;
  title(['Average', pairwise, 'RMSE for dataset at ', num2str(iter_num), ' iterations'], 'FontWeight', 'bold');
  xlabel('Number of columns K', 'FontWeight', 'bold');
  legend('-DynamicLegend', 'location', 'northeast');
  ylabel('Average RMSE', 'FontWeight', 'bold');

end