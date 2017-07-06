function [ ] = li_MLE_IP_demo(word1, word2)

  nsims = 1000;
  kvec = [2:2:100];

  % Type of random matrix: choice!
  option = 'normal'; % random normal matrix
  opt_para = 0; % technically no opt para




  % Demonstrate Li's method on Microsoft Word dataset
  % and also to test vectorized NR
  % Plot this every 50 iterations or so

  [w1, w2 ] = read_msoft_words_li(word1, word2, 'existence');

  X = [w1;w2];
  % normalize
  X = normalize_matrix_obs( X );

  % Marginal norms (should be 1) - but just in case
  m1 = sum(X(1,:).^2);
  m2 = sum(X(2,:).^2);
  true_IP = compute_generic_IP(X);

  % Run simulations
  max_k = max(kvec);
  
  % err_mat for ordinary method and li's method
  err_mat_ord = create_struct_to_save(zeros(nsims, length(kvec)), [word1, '_',  word2], 'naive_est_IP', nsims, true_IP);

  err_mat_li = create_struct_to_save(zeros(nsims, length(kvec)), [word1, '_',  word2], 'li_est_IP', nsims, true_IP);

  figure;

  for iter = 1:nsims
    iter 
    V = gen_typeof_V( X, max_k, 'option', option, 'opt_para', 1 );
    err_mat_ord.store(iter, :) = compute_generic_IP( V, 'is_sim', true, 'kvec', kvec);
    
    for kval = 1:length(kvec)
      k = kvec(kval);
      v1vec = V;
      v1vec.vmat = V.vmat(1,1:k);
      v2vec = V;
      v2vec.vmat = V.vmat(2,1:k);
      err_mat_li.store(iter, kval) = li_vectorized_NR_comp_IP( v1vec ,v2vec, m1, m2);
    end

    % Show the relative RMSE at every 2 iterations
    if mod(iter, 2) == 0
      clf('reset')      
      [ rmse_ord, ~] = compute_exp_and_MSE(err_mat_ord.store(1:iter, :), err_mat_ord, false);
      [ rmse_li, ~] = compute_exp_and_MSE(err_mat_li.store(1:iter, :), err_mat_li, false);
      local_plot_mse(kvec, rmse_ord, rmse_li, word1, word2, iter, false);
      drawnow

      % Save every 50 iter
      if mod(iter, 50) == 0
        [ rmse_ord, rel_err_ord] = compute_exp_and_MSE(err_mat_ord.store(1:iter, :), err_mat_ord, true);
        [ rmse_li, rel_err_li] = compute_exp_and_MSE(err_mat_li.store(1:iter, :), err_mat_li, false);
      end
    end

  end
  
  [ rmse_ord, rel_err_ord] = compute_exp_and_MSE(err_mat_ord.store, err_mat_ord, true);
  [ rmse_li, rel_err_li] = compute_exp_and_MSE(err_mat_li.store, err_mat_li, true);

  
  % Plot relative bias 
  local_plot_rel_err(kvec, rel_err_ord, rel_err_li, word1, word2, iter);
  
  % Plot relative MSE
  local_plot_mse(kvec, rmse_ord, rmse_li, word1, word2, iter, true);



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

