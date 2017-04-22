% Just in case: Remove all paths so far
% run('testing_script.m')
warning('off')
rmpath('Random_Projections/Generic_RP_code');
rmpath('Random_Projections/Improving_RP_with_Marginal_Info');
rmpath('Random_Projections/Random_Projections_with_Control_Variates');
rmpath('Random_Projections/Random_Projections_with_Control_Variates');
rmpath('Clustering_Algorithms/Basic_KNN');
warning('on')

addpath('Random_Projections/Generic_RP_code');
generic_results = runtests('genericTest.m')
rmpath('Random_Projections/Generic_RP_code');

