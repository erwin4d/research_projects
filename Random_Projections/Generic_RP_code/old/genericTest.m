% Ideally, tests all functions in these folders

function tests = genericTest
  tests = functiontests(localfunctions);
end

% Testing: Generic Random Projection Functions

% compute_generic_all_norm.m
% Test compute norm for X

function test_generic_all_norm_case1(testCase)
  X = [1,5,2; 3,1,7];
  exp_soln = sqrt(sum(X.^2,2));
  act_soln = compute_generic_all_norm( X, false);
  verifyEqual(testCase,act_soln,exp_soln)
end

% compute_generic_all_norm.m
% Test compute norm for V ; using normal

function test_generic_all_norm_case2(testCase)
  X = [1,5,2; 3,1,7];
  exp_soln = sqrt(sum(X.^2,2)/3);
  act_soln = compute_generic_all_norm( X, true, 'option', 'normal', 'is_sim', false);
end

% compute_generic_all_norm.m
% Test compute norm for V ; using normal
% and opt_para (should have no change)

function test_generic_all_norm_case3(testCase)
  X = [1,5,2; 3,1,7];
  exp_soln = sqrt(sum(X.^2,2)/3);
  act_soln = compute_generic_all_norm( X, true, 'option', 'normal', 'opt_para', 4, 'is_sim', false);
  verifyEqual(testCase,act_soln,exp_soln)
end


% compute_generic_all_norm.m
% Test compute norm for V ; using binary
% and opt_para (should have no change)

function test_generic_all_norm_case4(testCase)
  X = [1,5,2; 3,1,7];
  exp_soln = sqrt(sum(X.^2,2)/3);
  act_soln = compute_generic_all_norm( X, true, 'option', 'binary', 'opt_para', 4, 'is_sim', false);
  verifyEqual(testCase,act_soln,exp_soln)
end

% compute_generic_all_norm.m
% Test compute norm for V ; using SRHT
% and opt_para (should have no change)

function test_generic_all_norm_case5(testCase)
  X = [1,5,2; 3,1,7];
  exp_soln = sqrt(sum(X.^2,2)/3);
  act_soln = compute_generic_all_norm( X, true, 'option', 'SRHT', 'opt_para', 4, 'is_sim', false);
  verifyEqual(testCase,act_soln,exp_soln)
end



% compute_generic_all_norm.m
% Test compute norm for V ; using normal
% and opt_para (should have no change)

function test_generic_all_norm_case6(testCase)
  X = [1,5,2; 3,1,7];
  exp_soln = sqrt(cumsum(X.^2,2)./(1:3));
  act_soln = compute_generic_all_norm( X, true, 'option', 'normal', 'opt_para', 4, 'is_sim', true, 'kvec', 1:3);
  verifyEqual(testCase,act_soln,exp_soln)
end


% compute_generic_all_norm.m
% Test compute norm for V ; using binary
% and opt_para (should have no change)

function test_generic_all_norm_case7(testCase)
  X = [1,5,2; 3,1,7];
  exp_soln = sqrt(cumsum(X.^2,2)./(1:3));
  act_soln = compute_generic_all_norm( X, true, 'option', 'binary', 'opt_para', 4, 'is_sim', true, 'kvec', 1:3);
  verifyEqual(testCase,act_soln,exp_soln)
end

% compute_generic_all_norm.m
% Test compute norm for V ; using SRHT
% and opt_para (should have no change)

function test_generic_all_norm_case8(testCase)
  X = [1,5,2; 3,1,7];
  exp_soln = sqrt(cumsum(X.^2,2)./(1:3));
  act_soln = compute_generic_all_norm( X, true, 'option', 'SRHT', 'opt_para', 4, 'is_sim', true, 'kvec', 1:3);
  verifyEqual(testCase,act_soln,exp_soln)
end


% compute_generic_all_norm.m
% Test compute norm for V ; using SB
% and opt_para (should have change) + nosim

function test_generic_all_norm_case9(testCase)
  X = [1,5,2; 3,1,7];
  exp_soln = sqrt(sum(X.^2,2));
  act_soln = compute_generic_all_norm( X, true, 'option', 'SB', 'opt_para', 3, 'is_sim', false);
  verifyEqual(testCase,act_soln,exp_soln)
end

% compute_generic_all_norm.m
% Test compute norm for V ; using SB
% and opt_para (should have change) + sim

function test_generic_all_norm_case10(testCase)
  X = [1,5,2; 3,1,7];
  exp_soln = sqrt(3*cumsum(X.^2,2)./(1:3));
  act_soln = compute_generic_all_norm( X, true, 'option', 'SB', 'opt_para', 3, 'is_sim', true, 'kvec', 1:3);
  verifyEqual(testCase,act_soln,exp_soln)
end

% compute_generic_all_norm.m
% Test compute norm for V ; using normal
% and opt_para (should have no change)
% but with other kvec

function test_generic_all_norm_case11(testCase)
  X = [1,5,2; 3,1,7];
  tt = cumsum(X.^2,2);
  exp_soln = sqrt(tt(:,1:2)./(1:2));
  act_soln = compute_generic_all_norm( X, true, 'option', 'normal', 'opt_para', 4, 'is_sim', true, 'kvec', 1:2);
  verifyEqual(testCase,act_soln,exp_soln)
end

% compute_generic_ED.m
% Test compute ED for X

function test_generic_ED_case1(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = norm(X(1,:) - X(3,:));
  act_soln = compute_generic_ED( 1, 3, X, false);
  verifyEqual(testCase,act_soln,exp_soln)
end

% compute_generic_ED.m
% Test compute ED for V ; using normal

function test_generic_ED_case2(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = sqrt(sum((X(1,:) - X(3,:)).^2 / 3));
  act_soln = compute_generic_ED( 1, 3, X, true, 'option', 'normal', 'is_sim', false);
end

% compute_generic_ED.m
% Test compute ED for V ; using normal
% and opt_para (should have no change)

function test_generic_ED_case3(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = sqrt(sum((X(1,:) - X(3,:)).^2 / 3));
  act_soln = compute_generic_ED(1,3, X, true, 'option', 'normal', 'opt_para', 4, 'is_sim', false);
  verifyEqual(testCase,act_soln,exp_soln)
end


% compute_generic_ED.m
% Test compute ED for V ; using binary
% and opt_para (should have no change)

function test_generic_ED_case4(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = sqrt(sum((X(1,:) - X(3,:)).^2 / 3));
  act_soln = compute_generic_ED(1,3, X, true, 'option', 'binary', 'opt_para', 4, 'is_sim', false);
  verifyEqual(testCase,act_soln,exp_soln)
end

% compute_generic_ED.m
% Test compute ED for V ; using SRHT
% and opt_para (should have no change)

function test_generic_ED_case5(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = sqrt(sum((X(1,:) - X(3,:)).^2 / 3));
  act_soln = compute_generic_ED(1,3, X, true, 'option', 'SRHT', 'opt_para', 4, 'is_sim', false);
  verifyEqual(testCase,act_soln,exp_soln)
end


% compute_generic_ED.m
% Test compute ED for V ; using normal
% and opt_para (should have no change)

function test_generic_ED_case6(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = sqrt(cumsum((X(1,:) - X(3,:)).^2) ./ (1:3));
  act_soln = compute_generic_ED(1,3, X, true, 'option', 'normal', 'opt_para', 4, 'is_sim', true, 'kvec', 1:3);
  verifyEqual(testCase,act_soln,exp_soln)
end


% compute_generic_ED.m
% Test compute ED for V ; using binary
% and opt_para (should have no change)

function test_generic_ED_case7(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = sqrt(cumsum((X(1,:) - X(3,:)).^2) ./ (1:3));
  act_soln = compute_generic_ED(1,3, X, true, 'option', 'binary', 'opt_para', 4, 'is_sim', true, 'kvec', 1:3);
  verifyEqual(testCase,act_soln,exp_soln)
end

% compute_generic_ED.m
% Test compute ED for V ; using SRHT
% and opt_para (should have no change)

function test_generic_ED_case8(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = sqrt(cumsum((X(1,:) - X(3,:)).^2) ./ (1:3));
  act_soln = compute_generic_ED(1,3, X, true, 'option', 'SRHT', 'opt_para', 4, 'is_sim', true, 'kvec', 1:3);
  verifyEqual(testCase,act_soln,exp_soln)
end


% compute_generic_ED.m
% Test compute ED for V ; using SB
% and opt_para (should have change) + nosim

function test_generic_ED_case9(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = sqrt(sum((X(1,:) - X(3,:)).^2));
  act_soln = compute_generic_ED(1,3, X, true, 'option', 'SB', 'opt_para', 3, 'is_sim', false);
  verifyEqual(testCase,act_soln,exp_soln)
end

% compute_generic_ED.m
% Test compute ED for V ; using SB
% and opt_para (should have change) + sim

function test_generic_ED_case10(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = sqrt(3*cumsum((X(1,:) - X(3,:)).^2) ./ (1:3));
  act_soln = compute_generic_ED(1,3, X, true, 'option', 'SB', 'opt_para', 3, 'is_sim', true, 'kvec', 1:3);
  verifyEqual(testCase,act_soln,exp_soln)
end


% compute_generic_ED.m
% Test compute ED for V ; using normal
% and opt_para (should have no change)
% but with other kvec

function test_generic_ED_case11(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  tt = cumsum((X(1,:) - X(3,:)).^2);
  exp_soln = sqrt(tt(1:2)./ (1:2));
  act_soln = compute_generic_ED(1,3, X, true, 'option', 'normal', 'opt_para', 4, 'is_sim', true, 'kvec', 1:2);
  verifyEqual(testCase,act_soln,exp_soln)
end






























% compute_generic_IP.m
% Test compute ED for X

function test_generic_IP_case1(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = X(1,:) * X(3,:)';
  act_soln = compute_generic_IP( 1, 3, X, false);
  verifyEqual(testCase,act_soln,exp_soln)
end

% compute_generic_IP.m
% Test compute IP for V ; using normal

function test_generic_IP_case2(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = X(1,:) * X(3,:)'/3;
  act_soln = compute_generic_IP( 1, 3, X, true, 'option', 'normal', 'is_sim', false);
end

% compute_generic_IP.m
% Test compute IP for V ; using normal
% and opt_para (should have no change)

function test_generic_IP_case3(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = X(1,:) * X(3,:)'/3;
  act_soln = compute_generic_IP(1,3, X, true, 'option', 'normal', 'opt_para', 4, 'is_sim', false);
  verifyEqual(testCase,act_soln,exp_soln)
end


% compute_generic_IP.m
% Test compute IP for V ; using binary
% and opt_para (should have no change)

function test_generic_IP_case4(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = X(1,:) * X(3,:)'/3;
  act_soln = compute_generic_IP(1,3, X, true, 'option', 'binary', 'opt_para', 4, 'is_sim', false);
  verifyEqual(testCase,act_soln,exp_soln)
end

% compute_generic_IP.m
% Test compute IP for V ; using SRHT
% and opt_para (should have no change)

function test_generic_IP_case5(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = X(1,:) * X(3,:)'/3;
  act_soln = compute_generic_IP(1,3, X, true, 'option', 'SRHT', 'opt_para', 4, 'is_sim', false);
  verifyEqual(testCase,act_soln,exp_soln)
end


% compute_generic_IP.m
% Test compute IP for V ; using normal
% and opt_para (should have no change)

function test_generic_IP_case6(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = cumsum(X(1,:) .* X(3,:))./(1:3);
  act_soln = compute_generic_IP(1,3, X, true, 'option', 'normal', 'opt_para', 4, 'is_sim', true, 'kvec', 1:3);
  verifyEqual(testCase,act_soln,exp_soln)
end


% compute_generic_IP.m
% Test compute IP for V ; using binary
% and opt_para (should have no change)

function test_generic_IP_case7(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = cumsum(X(1,:) .* X(3,:))./(1:3);
  act_soln = compute_generic_IP(1,3, X, true, 'option', 'binary', 'opt_para', 4, 'is_sim', true, 'kvec', 1:3);
  verifyEqual(testCase,act_soln,exp_soln)
end

% compute_generic_IP.m
% Test compute IP for V ; using SRHT
% and opt_para (should have no change)

function test_generic_IP_case8(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = cumsum(X(1,:) .* X(3,:))./(1:3);
  act_soln = compute_generic_IP(1,3, X, true, 'option', 'SRHT', 'opt_para', 4, 'is_sim', true, 'kvec', 1:3);
  verifyEqual(testCase,act_soln,exp_soln)
end


% compute_generic_IP.m
% Test compute IP for V ; using SB
% and opt_para (should have change) + nosim

function test_generic_IP_case9(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = X(1,:) * X(3,:)';
  act_soln = compute_generic_IP(1,3, X, true, 'option', 'SB', 'opt_para', 3, 'is_sim', false);
  verifyEqual(testCase,act_soln,exp_soln)
end

% compute_generic_IP.m
% Test compute IP for V ; using SB
% and opt_para (should have change) + sim

function test_generic_IP_case10(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  exp_soln = 3*cumsum(X(1,:) .* X(3,:))./(1:3);
  act_soln = compute_generic_IP(1,3, X, true, 'option', 'SB', 'opt_para', 3, 'is_sim', true, 'kvec', 1:3);
  verifyEqual(testCase,act_soln,exp_soln)
end


% compute_generic_IP.m
% Test compute IP for V ; using normal
% and opt_para (should have no change)
% but with other kvec

function test_generic_IP_case11(testCase)
  X = [1,5,2; 3,1,7 ; 10 , -2, 5];
  tt = cumsum(X(1,:) .* X(3,:));
  exp_soln = tt(1:2)./ (1:2);
  act_soln = compute_generic_IP(1,3, X, true, 'option', 'normal', 'opt_para', 4, 'is_sim', true, 'kvec', 1:2);
  verifyEqual(testCase,act_soln,exp_soln)
end


% gen_typeof_R.m
% Can't really test much but let's check that the entries are least consistent

function test_gen_typeof_R_case1(testCase)
  p = 17;
  k = 5;
  R = gen_typeof_R(p, k, 'option', 'binary');
  act_soln = sum(sum(abs(R)));
  exp_soln = 85;
  verifyEqual(testCase,act_soln,exp_soln)
end


function test_gen_typeof_R_case2(testCase)
  p = 17;
  k = 5;
  R = gen_typeof_R(p, k, 'option', 'SB', 'opt_para', 2);
  act_soln = sum(sum(R == 0)) + sum(sum(R == -1)) + sum(sum(R == 1));
  exp_soln = 85;
  verifyEqual(testCase,act_soln,exp_soln)
end

function test_gen_typeof_R_case3(testCase)
  p = 4;
  k = 3;
  opt_para = [1,1 ,1 ,1 ; 1, -1, 1, -1 ; 1, 1, -1 , -1; 1, -1 , -1, 1];
  R = gen_typeof_R(p, k, 'option', 'SRHT', 'opt_para', opt_para);
  act_soln = sum(sum(R == -1)) + sum(sum(R == 1));
  exp_soln = 12;
  verifyEqual(testCase,act_soln,exp_soln)
end

