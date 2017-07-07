function [rmse] = control_variates_demo(X, niter, varargin)

  % Look at the average RMSE for pairwise <quantity> over entire dataset X
  % use random projection matrix of columns K = 10,20, ... 100 using
  % control variates method.

  % Inputs
  %            X: dataset
  %        niter: number of iterations
  %       option: type of random proj matrix
  %     opt_para: optional para for above random projection matrix
  %     pairwise: type of pairwise estimate needed (either squared_euclidean_distance or inner_product)
  %    partition: for computing true values - partition the x and y (vectorization / memory tradeoff)

  % Example inputs
  % control_variates_demo(X, 1000, 'option', 'normal', 'opt_para', -1, 'pairwise', 'squared_euclidean_distance','partition', 250);
  % control_variates_demo(X, 1000, 'option', 'normal', 'opt_para', -1, 'pairwise', 'inner_product','partition', 250);

  
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
  opt_para = inputs.opt_para;
  pairwise = inputs.pairwise;

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
  rmse.emp_cv = zeros(niter,length(kvec));
  rmse.theo_cv_li = zeros(niter,length(kvec));
  rmse.theo_cv_naive = zeros(niter,length(kvec));

  if strcmp(pairwise, 'inner_product')
	  rmse.li = zeros(niter,length(kvec));
  end


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
          [ests] = get_V_ests_all(currV);
          
          % Update ordinary estimate (for comparison)

          if strcmp(pairwise, 'squared_euclidean_distance')
          	[ests] = get_V_ests_all(currV, 'bivar_euc_theo', true);
            ests.li_ip = get_typeof_ests(ests, 'li_mle', []);

            rmse.ord(iter_num,kvals) = rmse.ord(iter_num,kvals) + get_rmse_all((ests.v1norm + ests.v2norm - 2*ests.v1v2), para, xseg, yseg);
            theo_naive = get_typeof_ests(ests, 'theo_euclidean_distance_naive', 'bivar_cv');
            theo_li = get_typeof_ests(ests, 'theo_euclidean_distance_li', 'bivar_cv');     

          elseif strcmp(pairwise, 'inner_product')

          	[ests] = get_V_ests_all(currV, 'bivar_ips_theo', true);
            ests.li_ip = get_typeof_ests(ests, 'li_mle', []);
            rmse.ord(iter_num,kvals) = rmse.ord(iter_num,kvals) + get_rmse_all(ests.v1v2, para, xseg, yseg);
            theo_naive = get_typeof_ests(ests, 'theo_inner_product_naive', 'bivar_cv');
            theo_li = get_typeof_ests(ests, 'theo_inner_product_li', 'bivar_cv');
            rmse.li(iter_num,kvals) = rmse.li(iter_num,kvals) + get_rmse_all(ests.li_ip, para, xseg, yseg);
          end


          rmse.theo_cv_naive(iter_num,kvals) = rmse.theo_cv_naive(iter_num,kvals) + get_rmse_all(theo_naive, para, xseg, yseg);
          rmse.theo_cv_li(iter_num,kvals) = rmse.theo_cv_li(iter_num,kvals) + get_rmse_all(theo_li, para, xseg, yseg);
          rmse.emp_cv(iter_num,kvals) = rmse.emp_cv(iter_num,kvals) + get_rmse_all(ests.mvn2d_est, para, xseg, yseg);

        end
      end
      rmse.ord(iter_num,kvals) = sqrt(rmse.ord(iter_num,kvals) / para.tot_num);
      rmse.theo_cv_li(iter_num,kvals) = sqrt(rmse.theo_cv_li(iter_num,kvals) / para.tot_num);
      rmse.theo_cv_naive(iter_num,kvals) = sqrt(rmse.theo_cv_naive(iter_num,kvals) / para.tot_num);
      rmse.emp_cv(iter_num,kvals) = sqrt(rmse.emp_cv(iter_num,kvals) / para.tot_num);

    


      if strcmp(pairwise, 'inner_product')
        rmse.li(iter_num,kvals) = sqrt(rmse.li(iter_num,kvals) / para.tot_num);
      end

    end
    % Plot: May want to edit plot settings for kvec starting from 10.
    %       May also want to tweak k as well.
    %       Note RMSE is independent of p! 
    if mod(iter_num, 10) == 0
      clf('reset');
    	local_plot(kvec, rmse, iter_num, false, pairwise)
      drawnow
    end
  end


end


function [ ] = local_plot(kvec, rmse, iter_num, fig_para, pairwise)

  if fig_para
    figure;
  end
  
  if strcmp(pairwise, 'inner_product')
  	sd_bounds = 'none'
  else
  	sd_bounds = 'non_negative'
  end

  local_plot_type(kvec, rmse.ord, iter_num, sd_bounds, 'Original estimate', 'r')

  if strcmp(pairwise, 'inner_product')
    local_plot_type(kvec, rmse.li, iter_num, sd_bounds, 'Li estimate', 'c')
  end

  local_plot_type(kvec, rmse.emp_cv, iter_num, sd_bounds , 'Empirical correction', 'g')
  local_plot_type(kvec, rmse.theo_cv_naive, iter_num, sd_bounds, 'Theoretical (naive) correction', 'b')
  local_plot_type(kvec, rmse.theo_cv_li, iter_num, sd_bounds, 'Theoretical (li) correction', 'm')


  grid on;
  if strcmp(pairwise, 'inner_product')
    title(['Average pairwise inner product RMSE for dataset at ', num2str(iter_num), ' iterations'], 'FontWeight', 'bold');
  else
    title(['Average pairwise Euclidean distance RMSE for dataset at ', num2str(iter_num), ' iterations'], 'FontWeight', 'bold');  	
  end

  xlabel('Number of columns K', 'FontWeight', 'bold');
  legend('-DynamicLegend', 'location', 'northeast');
  ylabel('Average RMSE', 'FontWeight', 'bold');

end

function [ ] = local_plot_type(kvec, rmse_mat, iter_num, typeof, legname, coltype)

  rmse_mean = mean(rmse_mat(1:iter_num,:),1);
  rmse_var = 3*sqrt(var(rmse_mat(1:iter_num,:),0,1));

  min_bound = rmse_mean - rmse_var;
  max_bound = rmse_mean + rmse_var;
  if strcmp(typeof, 'non_negative')
    min_bound(min_bound < 0) = 0;
  end

  plot(kvec,rmse_mean, ['-', coltype], 'DisplayName', legname); hold all
  plot(kvec,min_bound, ['--', coltype], 'DisplayName', 'Lower 3sd bound'); 
  plot(kvec,max_bound, ['--', coltype], 'DisplayName', 'Upper 3sd bound'); 


end
