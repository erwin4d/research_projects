function [ rmse_vec] = compare_generic_norm_demo(X, niter, varargin)

  
  p = inputParser;  
  p.addRequired('X',@(x) true);
  p.addRequired('niter',@(x) x > 0);
  p.addOptional('option', 'none', @(x) any(strcmp(x,{'normal', 'binary', 'SB'})));
  p.addOptional('opt_para', -1, @(x) true);
  p.parse(X, niter,varargin{:});
  inputs = p.Results;
  option = inputs.option;
  opt_para = inputs.opt_para;
  
  % Given a matrix X_{n x p}, compute all estimated norms
  % with a random projection matrix with k = 1, 2, .. 100 cols

  % Example input:

  % compare_generic_norm_demo(X, 1000, 'option', 'normal', 'opt_para', '1')
  % Look at RMSE of estimated norms using SB matrix of parameter 5.

  % We look at the average RMSE.
  
  K = 100; % Only looking at 100 cols.   
  rmse_vec = zeros(niter,K);

  X = normalize_matrix_obs(X); % normalize to have length 1 for standardized comparison of RMSE
  N = size(X,1);

  figure;
  for iter_num = 1:niter;
    iter_num
    V = gen_typeof_V(X, K, 'option', option, 'opt_para', opt_para);
    ests = rdivide(cumsum(V.vmat .^2,2), 1:K) * V.scaling_factor;  % Find estimates for each col
    rmse_vec(iter_num,:) = sqrt(sum((ests - 1).^2,1)/N);  % Find RMSE

    if mod(iter_num, 10) == 0
      clf('reset');
      local_plot(1:K, rmse_vec, iter_num, false)
      drawnow
    end

    % Plot: May want to edit plot settings for kvec starting from 10.
    %       May also want to tweak k as well.
    %       Note RMSE is independent of p! 
  end


end




function [ ] = local_plot(kvec, rmse, iter_num, fig_para)

  if fig_para
    figure;
  end

  plot_avg_sd_expts(kvec, rmse, iter_num, 'Estimate of norms', 'b')
  grid on;  

  title(['Average RMSE of norms at ', num2str(iter_num), ' iterations'], 'FontWeight', 'bold');
  xlabel('Number of columns K', 'FontWeight', 'bold');
  legend('-DynamicLegend', 'location', 'northeast');
  ylabel('Average RMSE', 'FontWeight', 'bold');


end


