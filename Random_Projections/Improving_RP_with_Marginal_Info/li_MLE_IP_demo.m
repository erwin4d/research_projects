function [ ] = li_MLE_IP_demo(X, niter, varargin)

  % Look at the average RMSE for pairwise inner product over entire dataset X
  % use random projection matrix of columns K = 10:10:100 using
  % li's method

  % Inputs
  %            X: dataset
  %        niter: number of iterations
  %       option: type of random proj matrix
  %     opt_para: optional para for above random projection matrix
  %    partition: for computing true values - partition the x and y (vectorization / memory tradeoff)

  % Example inputs
  % li_MLE_IP_demo(X, 1000, 'option', 'normal', 'opt_para', -1, 'partition', 250);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Defining parameters given inputs
  %  
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
    partition = min(size(X,1), 250); % Careful, will do matrix multplication on whole X
  else
    partition = inputs.partition;
  end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Build up para structure
  kvec = 10:10:100;
  rmse.ord = zeros(niter,length(kvec));
  rmse.li = zeros(niter,length(kvec));
  X = normalize_matrix_obs(X); % normalize to have length 1 for standardized comparison of RMSE

  para.N = size(X,1);  
  para.p = size(X,2);
  % Get partitions, true_vals, and total_number
  para = get_partitions_for_data(para, partition, kvec) ;
  para = get_true_vals_all(X, para, 'inner product');
  para.tot_num = (para.N*(para.N-1))/2;

  figure;
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
        % All we want is the inner product, and Li's estimate.

        ests.v1v2 = zeros(length(para.partition_start(xseg):para.partition_end(xseg)), length(para.partition_start(yseg):para.partition_end(yseg)), size(para.kidx,1));
        ests.v1norm = ests.v1v2;
        ests.v2norm = ests.v1v2;


        % Now, compute each individual parts. 
        for kvals = 1:length(kvec)
          currV = get_V_mats_given_k(currV, para, kvals);
          [ests] = get_V_ests_basic(currV, ests, kvals);
        end
        
        ests.v1v2 = cumsum(ests.v1v2,3);         
        ests.v1norm = cumsum(ests.v1norm,3);         
        ests.v2norm = cumsum(ests.v2norm,3);         

        for kvals = 1:length(kvec)
          % Now, record each estimate
          div_by = kvec(kvals) / currV.scaling_factor;
          ests.small_v1v2 = get_small_v_obs(ests.v1v2, kvals, div_by);
          ests.small_v1norm = get_small_v_obs(ests.v1norm, kvals, div_by);
          ests.small_v2norm = get_small_v_obs(ests.v2norm, kvals, div_by);          

          [li_ip] = get_typeof_ests(ests, 'li_mle', []);

          rmse.ord(iter_num,kvals) = rmse.ord(iter_num,kvals) + get_rmse_all(ests.small_v1v2, para, xseg, yseg);
          rmse.li(iter_num,kvals) = rmse.li(iter_num,kvals) + get_rmse_all(li_ip, para, xseg, yseg);


        end
      end
    end
    for kvals = 1:length(kvec)  
      rmse.ord(iter_num,kvals) = sqrt(rmse.ord(iter_num,kvals) / para.tot_num);
      rmse.li(iter_num,kvals) = sqrt(rmse.li(iter_num,kvals) / para.tot_num);
    end

    % Plot: May want to edit plot settings for kvec starting from 10.
    %       May also want to tweak k as well.
    %       Note RMSE is independent of p! 
    if mod(iter_num, 10) == 0
      clf('reset');
      local_plot(kvec, rmse, iter_num, false)
      drawnow
    end
  end


end


function [ ] = local_plot(kvec, rmse, iter_num, fig_para)

  if fig_para
    figure;
  end

  plot_avg_sd_expts(kvec, rmse.ord, iter_num, 'Ordinary estimate', 'k')
  plot_avg_sd_expts(kvec, rmse.li, iter_num, 'Li estimate', 'b')

  grid on;  

  title(['Average RMSE of pairwise inner products at ', num2str(iter_num), ' iterations'], 'FontWeight', 'bold');
  xlabel('Number of columns K', 'FontWeight', 'bold');
  legend('-DynamicLegend', 'location', 'northeast');
  ylabel('Average RMSE', 'FontWeight', 'bold');


end


