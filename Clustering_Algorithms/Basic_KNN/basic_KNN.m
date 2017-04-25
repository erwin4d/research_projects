function [ labels ] = basic_KNN( XTrain, XTest, YTrain, varargin)

  pars = inputParser;  
  pars.addRequired('XTrain',@(x) true);
  pars.addRequired('XTest',@(x) true);
  pars.addRequired('YTrain',@isvector);
  pars.addOptional('p', 2, @isnumeric);
  pars.addOptional('k', 5, @isnumeric);
  pars.addOptional('split_num', 100, @isnumeric);

  pars.parse( XTrain, XTest, YTrain , varargin{:});
  inputs = pars.Results;  
  
  p = inputs.p;
  k = inputs.k;
  split_num = inputs.split_num;

  % This performs basic K nearest neighbors
  % using lp distance parameterized by p
  % Code written for class homework BTRY 6520; used here
  % for basic clustering

  % XTrain, XTest ; matrices where rows are observations
  % YTrain ; labels for Train matrix
  % p - lp value
  % k - how many nearest neighbors?
  % split_num - used for even p ; when Z is too big

  % eg:
  % d_p = sum_{i=1}^D |x_{1,i} - x_{2,i}|^p

  % Initialize class_vec
  size_Test = size(XTest,1);
  size_Train = size(XTrain,1);

  labels = zeros(size_Test,1);
  
  % Split this into even p , and other p
  % Note that |    |^p when p is even is always positive ; not so when odd
  % This means for even p ,
  % can expand (x-y)^4 to x^4 - 4x^3y + 6x^2y^2 - 4xy^3 + y^4
  % and sum up each term

  % We can't do the above for odd powers because
  % |  |^p is positive but
  % (..)^p could be negative
  % bummer.


  if mod(p,2) == 0
  	% What's the binomial coefficients?
  	bin_coef = zeros(1, p+1);
    for i = 1:p+1;
      bin_coef(i) = nchoosek(p, i-1);
    end
    
    % Partition correctly
    start_vec = 1:split_num:size_Test;
    end_vec = split_num:split_num:size_Test;
    
    for ss = 1:(length(start_vec))
      
    	%if mod(ss,10) == 0
      %  ss
      %end
      labels(start_vec(ss):end_vec(ss)) = compute_LP_split_basic( XTrain, XTest(start_vec(ss):end_vec(ss),:), YTrain, split_num, p, k, bin_coef);
    end
  else
    for i = 1:size_Test;
      if (mod(i,10) == 1)
        i
      end
      labels(i) = compute_LP_normal_basic( XTrain, XTest(i,:), YTrain, size_Train, p, k);
    end  	
end

