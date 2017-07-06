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
  %    partition: for computing true values - partition the x and y (vectorization / memory tradeoff)

  % Example inputs
  % li_MLE_IP_demo(X, 1000, 'option', 'normal', 'opt_para', -1, 'partition', 250);

  
  p = inputParser;  
  p.addRequired('X',@(x) true);
  p.addRequired('niter',@(x) x > 0);
  p.addOptional('option', 'none', @(x) any(strcmp(x,{'normal', 'binary', 'SB'})));
  p.addOptional('opt_para', -1, @(x) true);
  p.addOptional('partition', -1, @(x) true); 

  p.parse(X, niter,varargin{:});
  inputs = p.Results;
  option = inputs.option;
  opt_para = inputs.opt_para;

  if inputs.partition == -1
    partition = size(X,1); % Careful, will do matrix multplication on whole X
  else
    partition = inputs.partition;
  end

  para.N = size(X,1);  

  para.partition_start = 1:partition:para.N;
  para.partition_end = partition:partition:para.N;

  if(para.partition_end(end)) ~= para.N
    para.partition_end = [para.partition_end, para.N];
  end


  kvec = 10:10:100;
  rmse.ord = zeros(niter,length(kvec));
  rmse.li = zeros(niter,length(kvec));

  X = normalize_matrix_obs(X); % normalize to have length 1 for standardized comparison of RMSE
  
  % Get true_vals
  para.true_val = triu(get_true_vals(X, para, 'inner_product'));

  para.tot_num = (para.N*(para.N+1))/2;

 figure;
  for iter_num = 1:niter;
    iter_num
    big_V = gen_typeof_V(X, max(kvec), 'option', option, 'opt_para', opt_para);
    for kvals = 1:length(kvec)
      k = kvec(kvals); 
      % We do the loop here which is repeated (use in subsequent experiments, so not as simplified)
      currV.scale = big_V.scaling_factor / k;
      for xseg = 1:length(para.partition_start)
        currV.V1 = big_V.vmat(para.partition_start(xseg):para.partition_end(xseg),1:k);
        for yseg = xseg:length(para.partition_start)
          currV.V2 = big_V.vmat(para.partition_start(yseg):para.partition_end(yseg),1:k);
          [ests] = get_V_ests_all(currV);
          
          % Update ordinary estimate (for comparison)
          rmse.ord(iter_num,kvals) = rmse.ord(iter_num,kvals) + get_rmse_all(ests.v1v2, para, xseg, yseg);
          
          %[li_ip] = cardano_fn(ests);
          li_ip = get_typeof_ests(ests, 'li_mle');

          rmse.li(iter_num,kvals) = rmse.li(iter_num,kvals) + get_rmse_all(li_ip, para, xseg, yseg);

        end
      end
      rmse.ord(iter_num,kvals) = sqrt(rmse.ord(iter_num,kvals) / para.tot_num);
      rmse.li(iter_num,kvals) = sqrt(rmse.li(iter_num,kvals) / para.tot_num);

    end
    % Plot: May want to edit plot settings for kvec starting from 10.
    %       May also want to tweak k as well.
    %       Note RMSE is independent of p! 
    if mod(iter_num, 10) == 0
      clf('reset');
      local_plot_licomp_err(kvec, rmse, iter_num, false)
      drawnow
    end
  end


end


function [ ] = local_plot_licomp_err(kvec, rmse, iter_num, fig_para)

  if fig_para
    figure;
  end
  
  rmse_ord_mean = mean(rmse.ord(1:iter_num,:),1);
  rmse_ord_var = 3*sqrt(var(rmse.ord(1:iter_num,:),0,1));

  min_ord_bound = rmse_ord_mean - rmse_ord_var;
  max_ord_bound = rmse_ord_mean + rmse_ord_var;

  plot(kvec,rmse_ord_mean, '-r', 'DisplayName', ['Average RMSE for ordinary estimate']); hold all
  plot(kvec,min_ord_bound, '--r', 'DisplayName', 'Lower 3sd bound'); 
  plot(kvec,max_ord_bound, '--r', 'DisplayName', 'Upper 3sd bound'); 

  rmse_li_mean = mean(rmse.li(1:iter_num,:),1);
  rmse_li_var = 3*sqrt(var(rmse.li(1:iter_num,:),0,1));

  min_li_bound = rmse_li_mean - rmse_li_var;
  max_li_bound = rmse_li_mean + rmse_li_var;

  plot(kvec,rmse_li_mean, '-b', 'DisplayName', ['Average RMSE for Li estimate']); 
  plot(kvec,min_li_bound, '--b', 'DisplayName', 'Lower 3sd bound'); 
  plot(kvec,max_li_bound, '--b', 'DisplayName', 'Upper 3sd bound'); 

  grid on;
  title(['Average inner product RMSE for dataset at ', num2str(iter_num), ' iterations'], 'FontWeight', 'bold');
  xlabel('Number of columns K', 'FontWeight', 'bold');
  legend('-DynamicLegend', 'location', 'northeast');
  ylabel('Average RMSE', 'FontWeight', 'bold');

end
