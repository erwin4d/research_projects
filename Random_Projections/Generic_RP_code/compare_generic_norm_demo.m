function [ ] = compare_generic_norm_demo(X, niter, varargin)

  
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

  % compare_generic_norm_demo(X, 1000, 'option', 'SB', opt_para, '5')
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
      local_plot_norm_err(1:K, rmse_vec, iter_num, false)
      drawnow
    end

    % Plot: May want to edit plot settings for kvec starting from 10.
    %       May also want to tweak k as well.
    %       Note RMSE is independent of p! 
  end


end


function [ ] = local_plot_norm_err(kvec, rmse_vec, iter_num, fig_para)

  if fig_para
    figure;
  end
  
  rmse_mean = mean(rmse_vec(1:iter_num,:),1);
  rmse_var = 3*sqrt(var(rmse_vec(1:iter_num,:),0,1));

  min_bound = rmse_mean - rmse_var;
  min_bound(min_bound < 0) = 0;
  max_bound = rmse_mean + rmse_var;

  plot(kvec,rmse_mean, '-r', 'DisplayName', 'Average RMSE for dataset'); hold all
  plot(kvec,min_bound, '--b', 'DisplayName', 'Lower 3sd bound'); 
  plot(kvec,max_bound, '--b', 'DisplayName', 'Upper 3sd bound'); 

  grid on;
  title(['Average RMSE for dataset at ', num2str(iter_num), ' iterations'], 'FontWeight', 'bold');
  xlabel('Number of columns K', 'FontWeight', 'bold');
  legend('-DynamicLegend', 'location', 'northeast');
  ylabel('Average RMSE', 'FontWeight', 'bold');

end