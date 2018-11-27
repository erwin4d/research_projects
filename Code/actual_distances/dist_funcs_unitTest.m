function tests = dist_funcs_unitTest()
  tests = functiontests(localfunctions);
end

function expSolution = loop_distmat(n1, n2, X1,X2, distfun, p)
  expSolution = zeros(n1,n2);
  for i = 1:n1
    for j = 1:n2
      vec1 = X1(i,:);
      vec2 = X2(j,:);
      expSolution(i,j) = distfun(vec1,vec2,p);  
    end
  end
end

function X_struct = createXStruct(X,n)
  X_struct.mat = X;
  X_struct.num_obs = n;
end 

function [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1AbsNormal()

  X1 = abs(normrnd(0,0.5,5,10));
  X2 = abs(normrnd(1,0.3,3,10));

  n1 = size(X1,1);
  n2 = size(X2,1);
  
  X1_struct = createXStruct(X1,n1);
  X2_struct = createXStruct(X2,n2);
end

function [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal()

  X1 = normrnd(0,0.5,5,10);
  X2 = normrnd(1,0.3,3,10);

  n1 = size(X1,1);
  n2 = size(X2,1);
  
  X1_struct = createXStruct(X1,n1);
  X2_struct = createXStruct(X2,n2);
end

function [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Binomial()

  X1 = binornd(0,0.5,5,10);
  X2 = binornd(1,0.3,3,10);

  n1 = size(X1,1);
  n2 = size(X2,1);
  
  X1_struct = createXStruct(X1,n1);
  X2_struct = createXStruct(X2,n2);
end

function [X1, X2, n1, n2, X1_struct, X2_struct] = createCase2Normal()

  X1 = normrnd(0,0.5,251,10);
  X2 = normrnd(1,0.3,3,10);

  n1 = size(X1,1);
  n2 = size(X2,1);
  
  X1_struct = createXStruct(X1,n1);
  X2_struct = createXStruct(X2,n2);
end

function [X1, X2, n1, n2, X1_struct, X2_struct] = createCase2Binomial()

  X1 = binornd(0,0.5,251,10);
  X2 = binornd(1,0.3,3,10);

  n1 = size(X1,1);
  n2 = size(X2,1);
  
  X1_struct = createXStruct(X1,n1);
  X2_struct = createXStruct(X2,n2);
end

function [X1, X2, n1, n2, X1_struct, X2_struct] = createCase2AbsNormal()

  X1 = abs(normrnd(0,0.5,251,10));
  X2 = abs(normrnd(1,0.3,3,10));

  n1 = size(X1,1);
  n2 = size(X2,1);
  
  X1_struct = createXStruct(X1,n1);
  X2_struct = createXStruct(X2,n2);
end

function [X1, X2, n1, n2, X1_struct, X2_struct] = createCase3Normal()

  X1 = normrnd(0,0.5,500,10);
  X2 = normrnd(1,0.3,631,10);

  n1 = size(X1,1);
  n2 = size(X2,1);
  
  X1_struct = createXStruct(X1,n1);
  X2_struct = createXStruct(X2,n2);
end

function [X1, X2, n1, n2, X1_struct, X2_struct] = createCase3Binomial()

  X1 = binornd(0,0.5,500,10);
  X2 = binornd(1,0.3,631,10);

  n1 = size(X1,1);
  n2 = size(X2,1);
  
  X1_struct = createXStruct(X1,n1);
  X2_struct = createXStruct(X2,n2);
end

function [X1, X2, n1, n2, X1_struct, X2_struct] = createCase3AbsNormal()

  X1 = abs(normrnd(0,0.5,500,10));
  X2 = abs(normrnd(1,0.3,631,10));

  n1 = size(X1,1);
  n2 = size(X2,1);
  
  X1_struct = createXStruct(X1,n1);
  X2_struct = createXStruct(X2,n2);
end

function [distfun] = findDistFun(distance_type)

  if strcmp(distance_type, 'angular_distance')
    distfun = @(vec1, vec2,p) acos(dot(vec1,vec2) / (norm(vec1) * norm(vec2)));
  elseif strcmp(distance_type, 'dot_product')
    distfun = @(vec1,vec2,p) dot(vec1,vec2);
  elseif (strcmp(distance_type, 'squared_Euclidean_distance') | strcmp(distance_type, 'squared_euclidean_distance'))
    distfun = @(vec1,vec2,p) norm(vec1-vec2)^2;
  elseif (strcmp(distance_type, 'Euclidean_distance') | strcmp(distance_type, 'euclidean_distance'))
    distfun = @(vec1,vec2,p) norm(vec1-vec2);
  elseif (strcmp(distance_type, 'squared_lp_distance'))
    distfun = @(vec1,vec2,p) sum((vec1-vec2).^p);
  elseif (strcmp(distance_type, 'lp_distance'))
    distfun = @(vec1,vec2,p) nthroot(sum((vec1-vec2).^p),p);
  elseif (strcmp(distance_type, 'l1_distance'))
    distfun = @(vec1,vec2,p) sum(abs(vec1-vec2));
  elseif (strcmp(distance_type, 'l_infinity_distance'))
    distfun = @(vec1,vec2,p) max(abs(vec1-vec2));
  elseif (strcmp(distance_type, 'jaccard_similarity'))
    distfun = @(vec1,vec2,p) sum(min(vec1,vec2)) / sum(max(vec1,vec2));
  elseif (strcmp(distance_type, 'resemblance'))
    distfun = @(vec1,vec2,p) sum(min(vec1,vec2)) / sum(max(vec1,vec2));
  elseif (strcmp(distance_type, 'hamming_distance'))
    distfun = @(vec1,vec2,p) sum(xor(vec1,vec2));
  end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_angular_distance.m

function testAngularDistance_matrix(testCase)
  
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_angular_distance(X1_struct, X2_struct);

  distfun = findDistFun('angular_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testAngularDistance_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_angular_distance(X1_struct, X2_struct);
  expSolution = 'angular_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_dot_product.m

function testDotProduct_matrix(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_dot_product(X1_struct, X2_struct);

  distfun = findDistFun('dot_product');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testDotProduct_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_dot_product(X1_struct, X2_struct);
  expSolution = 'dot_product';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_squared_euclidean_distance.m

function testSquaredEuclideanDistance_matrix(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_squared_euclidean_distance(X1_struct, X2_struct);

  distfun = findDistFun('squared_Euclidean_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testSquaredEuclideanDistance_name(testCase)
    
  [~,~,~,~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_squared_euclidean_distance(X1_struct, X2_struct);
  expSolution = 'squared_Euclidean_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_euclidean_distance.m

function testEuclideanDistance_matrix(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_euclidean_distance(X1_struct, X2_struct);

  distfun = findDistFun('Euclidean_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);


  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testEuclideanDistance_name(testCase)
    
  [~,~,~,~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_euclidean_distance(X1_struct, X2_struct);
  expSolution = 'Euclidean_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_squared_lp_even_distance.m

function testSquaredLPEven_matrix(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();  
  p = 4;

  actSolution = get_pairwise_squared_lp_even_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('squared_lp_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testSquaredLPEven_name(testCase)
    
  [~,~,~,~, X1_struct, X2_struct] = createCase1Normal();  
  p = 6;

  actSolution = get_pairwise_squared_lp_even_distance(X1_struct, X2_struct, p);
  expSolution = 'squared_lp_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testSquaredLPEven_p(testCase)
    
  [~,~,~,~, X1_struct, X2_struct] = createCase1Normal();  

  p = 6;

  actSolution = get_pairwise_squared_lp_even_distance(X1_struct, X2_struct, p);
  expSolution = 6;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testSquaredLPEven_wrong(testCase)
    
  [~,~,~,~, X1_struct, X2_struct] = createCase1Normal();  

  p = 3;

  actSolution = get_pairwise_squared_lp_even_distance(X1_struct, X2_struct, p);
  expSolution = 'error';
  verifyEqual(testCase,actSolution,expSolution)
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_lp_even_distance.m

function testLPEven_matrix(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();  
  p = 4;

  actSolution = get_pairwise_lp_even_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('lp_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testLPEven_name(testCase)
    
  [~,~,~,~, X1_struct, X2_struct] = createCase1Normal();  
  p = 6;

  actSolution = get_pairwise_lp_even_distance(X1_struct, X2_struct, p);
  expSolution = 'lp_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testLPEven_p(testCase)
    
  [~,~,~,~, X1_struct, X2_struct] = createCase1Normal();  
  p = 6;

  actSolution = get_pairwise_lp_even_distance(X1_struct, X2_struct, p);
  expSolution = 6;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testLPEven_wrong(testCase)
    
  [~,~,~,~, X1_struct, X2_struct] = createCase1Normal();  
  p = 3;

  actSolution = get_pairwise_lp_even_distance(X1_struct, X2_struct, p);
  expSolution = 'error';
  verifyEqual(testCase,actSolution,expSolution)
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_squared_lp_odd_distance.m

function testSquaredLPOdd_matrix1(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();  
  p = 3;

  actSolution = get_pairwise_squared_lp_odd_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('squared_lp_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testSquaredLPOdd_matrix2(testCase)
    
  [X2, X1, n2, n1, X2_struct, X1_struct] = createCase1Normal();  

  p = 3;

  actSolution = get_pairwise_squared_lp_odd_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('squared_lp_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testSquaredLPOdd_name(testCase)
    
  [~,~,~,~, X1_struct, X2_struct] = createCase1Normal();  

  p = 5;

  actSolution = get_pairwise_squared_lp_odd_distance(X1_struct, X2_struct, p);
  expSolution = 'squared_lp_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testSquaredLPOdd_p(testCase)
    
  [~,~,~,~, X1_struct, X2_struct] = createCase1Normal();  

  p = 3;

  actSolution = get_pairwise_squared_lp_odd_distance(X1_struct, X2_struct, p);
  expSolution = 3;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testSquaredLPOdd_wrong(testCase)
    
  [~,~,~,~, X1_struct, X2_struct] = createCase1Normal();  

  p = 4;

  actSolution = get_pairwise_squared_lp_odd_distance(X1_struct, X2_struct, p);
  expSolution = 'error';
  verifyEqual(testCase,actSolution,expSolution)
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_lp_odd_distance.m

function testLPOdd_matrix1(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();  
  p = 3;

  actSolution = get_pairwise_lp_odd_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('lp_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testLPOdd_matrix2(testCase)
    
  [X2, X1, n2, n1, X2_struct, X1_struct] = createCase1Normal();  
  p = 3;

  actSolution = get_pairwise_lp_odd_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('lp_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testLPOdd_name(testCase)
    
  [~,~,~,~, X1_struct, X2_struct] = createCase1Normal();  
  p = 5;

  actSolution = get_pairwise_lp_odd_distance(X1_struct, X2_struct, p);
  expSolution = 'lp_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testLPOdd_p(testCase)
    
  [~,~,~,~, X1_struct, X2_struct] = createCase1Normal();  

  p = 3;

  actSolution = get_pairwise_lp_odd_distance(X1_struct, X2_struct, p);
  expSolution = 3;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testLPOdd_wrong(testCase)
    
  [~,~,~,~, X1_struct, X2_struct] = createCase1Normal();  

  p = 4;

  actSolution = get_pairwise_lp_odd_distance(X1_struct, X2_struct, p);
  expSolution = 'error';
  verifyEqual(testCase,actSolution,expSolution)
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_l1_distance.m

function testL1distance_matrix1(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();  

  actSolution = get_pairwise_l1_distance(X1_struct, X2_struct);
  distfun = findDistFun('l1_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testL1distance_matrix2(testCase)
    
  [X2, X1, n2, n1, X2_struct, X1_struct] = createCase1Normal();  

  actSolution = get_pairwise_l1_distance(X1_struct, X2_struct);
  distfun = findDistFun('l1_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);


  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testL1distance_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  

  actSolution = get_pairwise_l1_distance(X1_struct, X2_struct);
  expSolution = 'l1_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testL1distance_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  


  actSolution = get_pairwise_l1_distance(X1_struct, X2_struct);
  expSolution = 1;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_l_infinity_distance.m

function testLinftydistance_matrix1(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();  

  actSolution = get_pairwise_l_infinity_distance(X1_struct, X2_struct);
  distfun = findDistFun('l_infinity_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);


  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testLinftydistance_matrix2(testCase)
    
  [X2, X1, n2, n1, X2_struct, X1_struct] = createCase1Normal();  

  actSolution = get_pairwise_l_infinity_distance(X1_struct, X2_struct);
  distfun = findDistFun('l_infinity_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);



  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testLinftydistance_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  


  actSolution = get_pairwise_l_infinity_distance(X1_struct, X2_struct);
  expSolution = 'l-infinity_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testLinftydistance_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  

  actSolution = get_pairwise_l_infinity_distance(X1_struct, X2_struct);
  expSolution = Inf;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_squared_lp_distance.m

function testSquaredLP_matrix1(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();  
  p = 4;

  actSolution = get_pairwise_squared_lp_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('squared_lp_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testSquaredLP_matrix2(testCase)
    
  [X2, X1, n2, n1, X2_struct, X1_struct] = createCase1Normal();  
  p = 4;

  actSolution = get_pairwise_squared_lp_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('squared_lp_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testSquaredLP_matrix3(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();  
  p = 3;

  actSolution = get_pairwise_squared_lp_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('squared_lp_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);


  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testSquaredLP_matrix4(testCase)
    
  [X2, X1, n2, n1, X2_struct, X1_struct] = createCase1Normal();  
  p = 3;

  actSolution = get_pairwise_squared_lp_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('squared_lp_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);


  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testSquaredLP_matrix5(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();  
  p = 1;

  actSolution = get_pairwise_squared_lp_distance(X1_struct, X2_struct, 1);
  distfun = findDistFun('l1_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);


  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testSquaredLP_matrix6(testCase)
    
  [X2, X1, n2, n1, X2_struct, X1_struct] = createCase1Normal();  
  p = 1;

  actSolution = get_pairwise_squared_lp_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('l1_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);


  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end



function testSquaredLP_matrix7(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();  
  p = Inf;

  actSolution = get_pairwise_squared_lp_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('l_infinity_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);


  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testSquaredLP_matrix8(testCase)
    
  [X2, X1, n2, n1, X2_struct, X1_struct] = createCase1Normal();  
  p = Inf;

  actSolution = get_pairwise_squared_lp_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('l_infinity_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);


  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end


function testSquaredLP_matrix9(testCase)

  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  
    
  p = 5;

  actSolution = get_pairwise_squared_lp_distance(X1_struct, X2_struct, p);
  expSolution = 'squared_lp_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testSquaredLP_matrix10(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  
  p = 1;

  actSolution = get_pairwise_squared_lp_distance(X1_struct, X2_struct, p);
  expSolution = 'l1_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testSquaredLP_matrix11(testCase)
    

  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  

  p = Inf;

  actSolution = get_pairwise_squared_lp_distance(X1_struct, X2_struct, p);
  expSolution = 'l-infinity_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testSquaredLP_matrix12(testCase)
    

  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  

  p = 5;

  actSolution = get_pairwise_squared_lp_distance(X1_struct, X2_struct, p);
  expSolution = 5;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testSquaredLP_matrix13(testCase)
    

  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  

  p = 2;

  actSolution = get_pairwise_squared_lp_distance(X1_struct, X2_struct, p);
  expSolution = 2;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testSquaredLP_matrix14(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  

  p = 1;

  actSolution = get_pairwise_squared_lp_distance(X1_struct, X2_struct, p);
  expSolution = 1;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testSquaredLP_matrix15(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  

  p = Inf;

  actSolution = get_pairwise_squared_lp_distance(X1_struct, X2_struct, p);
  expSolution = Inf;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_lp_distance.m

function testLP_matrix1(testCase)
    

  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();  
  p = 4;

  actSolution = get_pairwise_lp_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('lp_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testLP_matrix2(testCase)
    
  [X2, X1, n2, n1, X2_struct, X1_struct] = createCase1Normal();  
  p = 4;

  actSolution = get_pairwise_lp_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('lp_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);


  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testLP_matrix3(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();  
  p = 3;

  actSolution = get_pairwise_lp_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('lp_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testLP_matrix4(testCase)
    
  [X2, X1, n2, n1, X2_struct, X1_struct] = createCase1Normal();  
  p = 3;

  actSolution = get_pairwise_lp_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('lp_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, p);


  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testLP_matrix5(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();  
  p = 1;

  actSolution = get_pairwise_lp_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('l1_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testLP_matrix6(testCase)
    
  [X2, X1, n2, n1, X2_struct, X1_struct] = createCase1Normal();  
  p = 1;

  actSolution = get_pairwise_lp_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('l1_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end



function testLP_matrix7(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Normal();  
  p = Inf;

  actSolution = get_pairwise_lp_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('l_infinity_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testLP_matrix8(testCase)
    
  [X2, X1, n2, n1, X2_struct, X1_struct] = createCase1Normal();  
  p = Inf;

  actSolution = get_pairwise_lp_distance(X1_struct, X2_struct, p);
  distfun = findDistFun('l_infinity_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end


function testLP_matrix9(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  

  p = 5;

  actSolution = get_pairwise_lp_distance(X1_struct, X2_struct, p);
  expSolution = 'lp_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testLP_matrix10(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  

  p = 1;

  actSolution = get_pairwise_lp_distance(X1_struct, X2_struct, p);
  expSolution = 'l1_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testLP_matrix11(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  

  p = Inf;

  actSolution = get_pairwise_lp_distance(X1_struct, X2_struct, p);
  expSolution = 'l-infinity_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testLP_matrix12(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  

  p = 5;

  actSolution = get_pairwise_lp_distance(X1_struct, X2_struct, p);
  expSolution = 5;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testLP_matrix13(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  

  p = 2;

  actSolution = get_pairwise_lp_distance(X1_struct, X2_struct, p);
  expSolution = 2;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testLP_matrix14(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  

  p = 1;

  actSolution = get_pairwise_lp_distance(X1_struct, X2_struct, p);
  expSolution = 1;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testLP_matrix15(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  

  p = Inf;

  actSolution = get_pairwise_lp_distance(X1_struct, X2_struct, p);
  expSolution = Inf;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_jaccard_similarity.m

function testJaccardSimilarity_matrix1(testCase)

  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1AbsNormal();

  actSolution = get_pairwise_jaccard_similarity(X1_struct, X2_struct);

  distfun = findDistFun('jaccard_similarity');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testJaccardSimilarity_matrix2(testCase)
    
  [X2, X1, n2, n1, X2_struct, X1_struct] = createCase1AbsNormal();

  actSolution = get_pairwise_jaccard_similarity(X1_struct, X2_struct);

  distfun = findDistFun('jaccard_similarity');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testJaccardSimilarity_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1AbsNormal();

  actSolution = get_pairwise_jaccard_similarity(X1_struct, X2_struct);
  expSolution = 'jaccard_similarity';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_resemblance.m

function testResemblance_matrix1(testCase)

  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Binomial();

  actSolution = get_pairwise_resemblance(X1_struct, X2_struct);

  distfun = findDistFun('resemblance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);
    
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testResemblance_matrix2(testCase)
    
  [X2, X1, n2, n1, X2_struct, X1_struct] = createCase1Binomial();

  actSolution = get_pairwise_resemblance(X1_struct, X2_struct);

  distfun = findDistFun('resemblance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);


  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testResemblance_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Binomial();

  actSolution = get_pairwise_resemblance(X1_struct, X2_struct);
  expSolution = 'resemblance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_hamming_distance.m

function testHammingdistance_matrix1(testCase)
    
  [X1, X2, n1, n2, X1_struct, X2_struct] = createCase1Binomial();  

  actSolution = get_pairwise_hamming_distance(X1_struct, X2_struct);

  distfun = findDistFun('hamming_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testHammingdistance_matrix2(testCase)
    
  [X2, X1, n2, n1, X2_struct, X1_struct] = createCase1Binomial();  

  actSolution = get_pairwise_hamming_distance(X1_struct, X2_struct);

  distfun = findDistFun('hamming_distance');
  expSolution = loop_distmat(n1, n2, X1,X2, distfun, -1);


  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution,10))
end

function testHammingdistance_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Binomial();  

  actSolution = get_pairwise_hamming_distance(X1_struct, X2_struct);
  expSolution = 'hamming_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Test get_pairwise_distances.m
%%%%%%%% Test get_pairwise_distances_big.m


function testPairwiseDistance_angular_distance_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'angular_distance');
  expSolution = get_pairwise_angular_distance(X1_struct,X2_struct);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_angular_distance_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'angular_distance');
  expSolution = 'angular_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testbigPairwiseDistance_angular_distance_matrix2(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'angular_distance');
  expSolution = get_pairwise_angular_distance(X1_struct,X2_struct);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_angular_distance_name2(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'angular_distance');
  expSolution = 'angular_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testbigPairwiseDistance_angular_distance_matrix3(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase2Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'angular_distance');
  expSolution = get_pairwise_angular_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_angular_distance_matrix4(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase2Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'angular_distance');
  expSolution = get_pairwise_angular_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_angular_distance_matrix5(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase3Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'angular_distance');
  expSolution = get_pairwise_angular_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_angular_distance_matrix6(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase3Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'angular_distance');
  expSolution = get_pairwise_angular_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end



function testPairwiseDistance_dot_product_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'dot_product');
  expSolution = get_pairwise_dot_product(X1_struct,X2_struct);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_dot_product_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'dot_product');
  expSolution = 'dot_product';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testbigPairwiseDistance_dot_product_matrix2(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'dot_product');
  expSolution = get_pairwise_dot_product(X1_struct,X2_struct);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_dot_product_name2(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'dot_product');
  expSolution = 'dot_product';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testbigPairwiseDistance_dot_product_matrix3(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase2Normal();


  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'dot_product');
  expSolution = get_pairwise_dot_product(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_dot_product_matrix4(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase2Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'dot_product');
  expSolution = get_pairwise_dot_product(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_dot_product_matrix5(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase3Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'dot_product');
  expSolution = get_pairwise_dot_product(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_dot_product_matrix6(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase3Normal();


  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'dot_product');
  expSolution = get_pairwise_dot_product(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_euclidean_distance_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'euclidean_distance');
  expSolution = get_pairwise_euclidean_distance(X1_struct,X2_struct);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_euclidean_distance_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'euclidean_distance');
  expSolution = 'Euclidean_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testbigPairwiseDistance_euclidean_distance_matrix2(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'euclidean_distance');
  expSolution = get_pairwise_euclidean_distance(X1_struct,X2_struct);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_euclidean_distance_name2(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'euclidean_distance');
  expSolution = 'Euclidean_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testbigPairwiseDistance_euclidean_distance_matrix3(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase2Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'euclidean_distance');
  expSolution = get_pairwise_euclidean_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_euclidean_distance_matrix4(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase2Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'euclidean_distance');
  expSolution = get_pairwise_euclidean_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_euclidean_distance_matrix5(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase3Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'euclidean_distance');
  expSolution = get_pairwise_euclidean_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_euclidean_distance_matrix6(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase3Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'euclidean_distance');
  expSolution = get_pairwise_euclidean_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end



function testPairwiseDistance_squared_euclidean_distance_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'squared_euclidean_distance');
  expSolution = get_pairwise_squared_euclidean_distance(X1_struct,X2_struct);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_squared_euclidean_distance_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'squared_euclidean_distance');
  expSolution = 'squared_Euclidean_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testbigPairwiseDistance_squared_euclidean_distance_matrix2(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_euclidean_distance');
  expSolution = get_pairwise_squared_euclidean_distance(X1_struct,X2_struct);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_squared_euclidean_distance_name2(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_euclidean_distance');
  expSolution = 'squared_Euclidean_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testbigPairwiseDistance_squared_euclidean_distance_matrix3(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase2Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_euclidean_distance');
  expSolution = get_pairwise_squared_euclidean_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_squared_euclidean_distance_matrix4(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase2Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_euclidean_distance');
  expSolution = get_pairwise_squared_euclidean_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_squared_euclidean_distance_matrix5(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase3Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_euclidean_distance');
  expSolution = get_pairwise_squared_euclidean_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_squared_euclidean_distance_matrix6(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase3Normal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_euclidean_distance');
  expSolution = get_pairwise_squared_euclidean_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end




function testPairwiseDistance_jaccard_similarity_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1AbsNormal();

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'jaccard_similarity');
  expSolution = get_pairwise_jaccard_similarity(X1_struct,X2_struct);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_jaccard_similarity_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1AbsNormal();

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'jaccard_similarity');
  expSolution = 'jaccard_similarity';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testbigPairwiseDistance_jaccard_similarity_matrix2(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase1AbsNormal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'jaccard_similarity');
  expSolution = get_pairwise_jaccard_similarity(X1_struct,X2_struct);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_jaccard_similarity_name2(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase1AbsNormal();

  actSolution = get_pairwise_distances_big(X2_struct, X1_struct, 'jaccard_similarity');
  expSolution = 'jaccard_similarity';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testbigPairwiseDistance_jaccard_similarity_matrix3(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase1AbsNormal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'jaccard_similarity');
  expSolution = get_pairwise_jaccard_similarity(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_jaccard_similarity_matrix4(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase2AbsNormal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'jaccard_similarity');
  expSolution = get_pairwise_jaccard_similarity(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_jaccard_similarity_matrix5(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase3AbsNormal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'jaccard_similarity');
  expSolution = get_pairwise_jaccard_similarity(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_jaccard_similarity_matrix6(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase3AbsNormal();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'jaccard_similarity');
  expSolution = get_pairwise_jaccard_similarity(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_hamming_distance_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Binomial();

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'hamming_distance');
  expSolution = get_pairwise_hamming_distance(X1_struct,X2_struct);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_hamming_distance_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Binomial();

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'hamming_distance');
  expSolution = 'hamming_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testbigPairwiseDistance_hamming_distance_matrix2(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase1Binomial();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'hamming_distance');
  expSolution = get_pairwise_hamming_distance(X1_struct,X2_struct);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_hamming_distance_name2(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase1Binomial();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'hamming_distance');
  expSolution = 'hamming_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testbigPairwiseDistance_hamming_distance_matrix3(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase2Binomial();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'hamming_distance');
  expSolution = get_pairwise_hamming_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_hamming_distance_matrix4(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase2Binomial();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'hamming_distance');
  expSolution = get_pairwise_hamming_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_hamming_distance_matrix5(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase3Binomial();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'hamming_distance');
  expSolution = get_pairwise_hamming_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_hamming_distance_matrix6(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase3Binomial();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'hamming_distance');
  expSolution = get_pairwise_hamming_distance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_resemblance_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Binomial();
  
  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'resemblance');
  expSolution = get_pairwise_resemblance(X1_struct,X2_struct);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_resemblance_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Binomial();

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'resemblance');
  expSolution = 'resemblance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testbigPairwiseDistance_resemblance_matrix2(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase1Binomial();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'resemblance');
  expSolution = get_pairwise_resemblance(X1_struct,X2_struct);

  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_resemblance_name2(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase1Binomial();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'resemblance');
  expSolution = 'resemblance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testbigPairwiseDistance_resemblance_matrix3(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase2Binomial();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'resemblance');
  expSolution = get_pairwise_resemblance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_resemblance_matrix4(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase2Binomial();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'resemblance');
  expSolution = get_pairwise_resemblance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_resemblance_matrix5(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase3Binomial();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'resemblance');
  expSolution = get_pairwise_resemblance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testbigPairwiseDistance_resemblance_matrix6(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase3Binomial();

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'resemblance');
  expSolution = get_pairwise_resemblance(X1_struct,X2_struct); % should work if not too big
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end




function testPairwiseDistance_lpdistance1_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 1;
  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_lpdistance1_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();
  
  p = 1;
  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = 'l1_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_lpdistance1_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 1;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testPairwiseDistance_lpdistance2_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 2;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_lpdistance2_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 2;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = 'lp_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_lpdistance2_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  
  p = 2;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end


function testPairwiseDistance_lpdistance3_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 3;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_lpdistance3_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 3;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = 'lp_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_lpdistance3_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 3;
  
  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testPairwiseDistance_lpdistanceinf_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = Inf;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_lpdistanceinf_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = Inf;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = 'l-infinity_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_lpdistanceinf_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = Inf;
  
  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end




function testPairwiseDistance_squared_lpdistance1_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 1;
  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_squared_lpdistance1_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 1;
  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = 'l1_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_squared_lpdistance1_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 1;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testPairwiseDistance_squared_lpdistance2_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 2;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_squared_lpdistance2_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 2;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = 'squared_lp_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_squared_lpdistance2_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 2;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end


function testPairwiseDistance_squared_lpdistance3_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();
  p = 3;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_squared_lpdistance3_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 3;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = 'squared_lp_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_squared_lpdistance3_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();
  
  p = 3;
  
  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testPairwiseDistance_squared_lpdistanceinf_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = Inf;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_squared_lpdistanceinf_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = Inf;

  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = 'l-infinity_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_squared_lpdistanceinf_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  
  p = Inf;
  
  actSolution = get_pairwise_distances(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end







function testPairwiseDistance_big_lpdistance1_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 1;
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_lpdistance1_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 1;
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = 'l1_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_big_lpdistance1_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 1;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testPairwiseDistance_big_lpdistance2_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 2;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_lpdistance2_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 2;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = 'lp_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_big_lpdistance2_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 2;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end


function testPairwiseDistance_big_lpdistance3_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 3;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_lpdistance3_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 3;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = 'lp_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_big_lpdistance3_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 3;
  
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testPairwiseDistance_big_lpdistanceinf_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = Inf;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_lpdistanceinf_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = Inf;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = 'l-infinity_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_big_lpdistanceinf_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();  
  p = Inf;
  
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end




function testPairwiseDistance_big_squared_lpdistance1_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 1;
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_squared_lpdistance1_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 1;
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = 'l1_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_big_squared_lpdistance1_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 1;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testPairwiseDistance_big_squared_lpdistance2_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 2;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_squared_lpdistance2_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();
  
  p = 2;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = 'squared_lp_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_big_squared_lpdistance2_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 2;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end


function testPairwiseDistance_big_squared_lpdistance3_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 3;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_squared_lpdistance3_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  
  p = 3;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = 'squared_lp_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_big_squared_lpdistance3_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = 3;
  
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end

function testPairwiseDistance_big_squared_lpdistanceinf_matrix(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = Inf;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_squared_lpdistanceinf_name(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = Inf;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = 'l-infinity_distance';
  verifyEqual(testCase,actSolution.dist_type,expSolution)
end

function testPairwiseDistance_big_squared_lpdistanceinf_p(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase1Normal();

  p = Inf;
  
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = p;
  verifyEqual(testCase,actSolution.dist_p,expSolution)
end


function testPairwiseDistance_big_lpdistance1_matrix1(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase2Normal();

  p = 1;
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_lpdistance1_matrix2(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase2Normal();

  p = 1;
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_lpdistance1_matrix3(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase3Normal();

  p = 1;
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_lpdistance1_matrix4(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase3Normal();

  p = 1;
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_lpdistance2_matrix1(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase2Normal();

  p = 2;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_lpdistance2_matrix2(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase2Normal();

  p = 2;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_lpdistance2_matrix3(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase3Normal();

  p = 2;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_lpdistance2_matrix4(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase3Normal();

  p = 2;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_lpdistance3_matrix1(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase2Normal();

  p = 3;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_lpdistance3_matrix2(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase2Normal();

  p = 3;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_lpdistance3_matrix3(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase3Normal();

  p = 3;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_lpdistance3_matrix4(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase3Normal();

  p = 3;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_lpdistanceinf_matrix1(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase2Normal();

  p = Inf;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_lpdistanceinf_matrix2(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase2Normal();

  p = Inf;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_lpdistanceinf_matrix3(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase3Normal();

  p = Inf;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_lpdistanceinf_matrix4(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase3Normal();

  p = Inf;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'lp_distance', p);
  expSolution = get_pairwise_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end




function testPairwiseDistance_big_squared_lpdistance1_matrix1(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase2Normal();

  p = 1;
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_squared_lpdistance1_matrix2(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase2Normal();

  p = 1;
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_squared_lpdistance1_matrix3(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase3Normal();

  p = 1;
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_squared_lpdistance1_matrix4(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase3Normal();

  p = 1;
  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_squared_lpdistance2_matrix1(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase2Normal();

  p = 2;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_squared_lpdistance2_matrix2(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase2Normal();

  p = 2;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_squared_lpdistance2_matrix3(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase3Normal();

  p = 2;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_squared_lpdistance2_matrix4(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase3Normal();

  p = 2;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end



function testPairwiseDistance_big_squared_lpdistance3_matrix1(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase2Normal();

  p = 3;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_squared_lpdistance3_matrix2(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase2Normal();

  p = 3;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_squared_lpdistance3_matrix3(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase3Normal();

  p = 3;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_squared_lpdistance3_matrix4(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase3Normal();

  p = 3;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_squared_lpdistanceinf_matrix1(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase2Normal();

  p = Inf;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end

function testPairwiseDistance_big_squared_lpdistanceinf_matrix2(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase2Normal();

  p = Inf;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_squared_lpdistanceinf_matrix3(testCase)
    
  [~, ~, ~, ~, X1_struct, X2_struct] = createCase3Normal();

  p = Inf;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end


function testPairwiseDistance_big_squared_lpdistanceinf_matrix4(testCase)
    
  [~, ~, ~, ~, X2_struct, X1_struct] = createCase3Normal();

  p = Inf;

  actSolution = get_pairwise_distances_big(X1_struct, X2_struct, 'squared_lp_distance', p);
  expSolution = get_pairwise_squared_lp_distance(X1_struct,X2_struct,p);
  verifyEqual(testCase,round(actSolution.dist_mat,10),round(expSolution.dist_mat,10))
end
