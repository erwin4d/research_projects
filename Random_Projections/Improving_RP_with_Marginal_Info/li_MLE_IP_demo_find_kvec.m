function [ ] = li_MLE_IP_demo_find_kvec(word1, word2, kvec, varargin)

  %kvec = [1:30:1000]
  p = inputParser;  
  p.addRequired('word1',@ischar);
  p.addRequired('word2',@ischar);
  p.addRequired('kvec',@isvector);
  p.addOptional('nsims', 100, @isscalar);
  p.parse(word1, word2, kvec, varargin{:});

  inputs = p.Results;
  nsims = inputs.nsims;

  % Type of random matrix: choice!
  option = 'normal'; % random normal matrix
  opt_para = 0; % technically no opt para




  % Demonstrate Li's method on Microsoft Word dataset
  % and also to test vectorized NR
  % Plot this every 50 iterations or so


  [w1, w2 ] = read_msoft_words_li(word1, word2, 'existence');

  X = [w1;w2];
  % normalize
  X = X ./ sqrt(sum(X.^2,2));
  % Marginal norms (should be 1)
  m1 = sum(X(1,:).^2);
  m2 = sum(X(2,:).^2);

  true_IP = compute_generic_IP(1,2,X,false);

  % Run simulations
  max_k = max(kvec);
  
  % err_mat for ordinary method and li's method
  err_mat_ord = zeros(nsims, length(kvec));
  err_mat_li = zeros(nsims, length(kvec));

  rmse_vec = zeros(1, length(kvec));

  figure;
  for kval = 1:length(kvec)
    k = kvec(kval)
    for iter = 1:nsims
      V = gen_typeof_V( X, k, 'option', option, 'opt_para', 1 );
      err_mat_li(iter, kval) = li_vectorized_NR_comp_IP( V(1,1:k) , V(2,1:k), m1, m2, 'option', option, 'opt_para', opt_para );
      err_mat_ord(iter, kval) = compute_generic_IP( 1,  2,  V,  true, 'option', option, 'opt_para', opt_para, 'is_sim', true);  
    end
    [ rmse_ord, ~] = compute_exp_and_MSE(err_mat_ord(:, 1:kval), true_IP, word1, word2, iter, 'option', 'ordinary', 'tosave', false);
    [ rmse_li, ~] = compute_exp_and_MSE(err_mat_li(:, 1:kval), true_IP, word1, word2, iter, 'option', 'MLE', 'tosave' , false);  
    
    
    clf('reset')      
    local_plot_mse(kvec(1:kval), rmse_ord, rmse_li, word1, word2, iter, false);
    drawnow
  end


end

function [ ] = local_plot_rel_err(kvec, rel_err_ord, rel_err_li, word1, word2, iter)

  figure;
  plot(kvec,rel_err_ord, '-r', 'DisplayName', 'Ordinary Estimation'); hold all
  plot(kvec,rel_err_li, '-b', 'DisplayName', 'MLE Estimation');
  grid on;
  title([word1, '-', word2,' Relative bias in estimation of IP for ', num2str(iter), ' iterations'], 'FontWeight', 'bold');
  xlabel('Number of columns K', 'FontWeight', 'bold');
  legend('-DynamicLegend');
  ylabel('Relative Bias', 'FontWeight', 'bold');

end

function [ ] = local_plot_mse(kvec, rmse_ord, rmse_li, word1, word2, iter, fig_para)

  if fig_para
    figure;
  end

  plot(kvec,rmse_ord, '-r', 'DisplayName', 'Ordinary Estimation'); hold all
  plot(kvec,rmse_li, '-b', 'DisplayName', 'MLE Estimation');
  grid on;
  title([word1, '-', word2,' Relative RMSE in estimation of IP for ', num2str(iter), ' iterations'], 'FontWeight', 'bold');
  xlabel('Number of columns K', 'FontWeight', 'bold');
  legend('-DynamicLegend');
  ylabel('Relative RMSE', 'FontWeight', 'bold');

end

