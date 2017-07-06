function [rmse_vec ] = compare_generic_pairwise_demo(X, niter, varargin)

  % Look at the average RMSE for pairwise <quantity> over entire dataset X
  % use random projection matrix of columns K = 10,20, ... 100

  % Inputs
  %            X: dataset
  %        niter: number of iterations
  %       option: type of random proj matrix
  %     opt_para: optional para for above random projection matrix
  %     pairwise: type of pairwise estimate needed
  %    partition: for computing true values - partition the x and y (vectorization / memory tradeoff)

  % Example inputs
  % compare_generic_pairwise_demo(X, 1000, 'option', 'normal', 'opt_para', -1, 'pairwise', 'inner_product', 'partition', 250)

  
  
  p = inputParser;  
  p.addRequired('X',@(x) true);
  p.addRequired('niter',@(x) x > 0);
  p.addOptional('option', 'none', @(x) any(strcmp(x,{'normal', 'binary', 'SB'})));
  p.addOptional('opt_para', -1, @(x) true);
  p.addOptional('pairwise', 'none', @(x) any(strcmp(x,{'squared_euclidean_distance', 'inner_product'})));
  p.addOptional('partition', -1, @(x) true); 

  p.parse(X, niter,varargin{:});
  inputs = p.Results;
  option = inputs.option;
  pairwise = inputs.pairwise;
  opt_para = inputs.opt_para;
  disp(['Computing estimates of ', pairwise])

  para.N = size(X,1);  
  if inputs.partition == -1
    partition = size(X,1); % Careful, will do matrix multplication on whole X
  else
    partition = inputs.partition;
  end

  para.partition_start = 1:partition:para.N;
  para.partition_end = partition:partition:para.N;

  if(para.partition_end(end)) ~= para.N
    para.partition_end = [para.partition_end, para.N];
  end
  

  kvec = 10:10:100;
  rmse_vec = zeros(niter,length(kvec));

  X = normalize_matrix_obs(X); % normalize to have length 1 for standardized comparison of RMSE
  
  % Get true_vals
  para.true_val = triu(get_true_vals(X, para, pairwise));
    
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
          if xseg ~= yseg
            truevals = get_V_ests_generic(currV, pairwise) ; 
          else
            truevals = triu(get_V_ests_generic(currV, pairwise)) ;             
          end
          
          rmse_vec(iter_num,kvals) = rmse_vec(iter_num,kvals) + sum(sum((para.true_val(para.partition_start(xseg):para.partition_end(xseg), para.partition_start(yseg):para.partition_end(yseg)) - truevals).^2));
        end
      end
      rmse_vec(iter_num,kvals) = sqrt(rmse_vec(iter_num,kvals) / para.tot_num);
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