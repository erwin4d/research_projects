
% Some intuition on how well this does

kvals = 10:10:1000;
numiter = 1000;

% Use colon data
[X, ~] = load_colon();

% Center and standardize for just two vectors
[ X_struct_small ] = build_X_struct(X(1:2,:), true, true)  

[results_euclidean_one] = compare_generic_distance_simulation(X_struct_small, kvals, numiter, 'euclidean_distance');
[results_dotproduct_one] = compare_generic_distance_simulation(X_struct_small, kvals, numiter, 'dot_product');

% Center and standardize for all pairwise vectors
[ X_struct ] = build_X_struct(X, true, true)  

[results_euclidean_all] = compare_generic_distance_simulation(X_struct, kvals, numiter, 'euclidean_distance');
[results_dotproduct_all] = compare_generic_distance_simulation(X_struct, kvals, numiter, 'dot_product');

% Let's plot some graphs

plot(kvals,mean(results_euclidean_one), 'k', 'DisplayName', 'Euclidean Distance for one pair'); hold all
plot(kvals,mean(results_dotproduct_one), 'r', 'DisplayName', 'Dot Product for one pair'); 
plot(kvals,mean(results_euclidean_all), '--k', 'DisplayName', 'Euclidean Distance for all pairs'); 
plot(kvals,mean(results_dotproduct_all), '--r', 'DisplayName', 'Dot Product for all pairs'); 

ylim([0 1])
xlim([10,1000])

grid on;

title(['Plot of relative RMSE against number of dimensions projected to'], 'FontWeight', 'bold','FontSize', 30);

xlabel('Number of dimensions k', 'FontWeight', 'bold','FontSize', 40);
xt = get(gca, 'XTick');
set(gca, 'FontSize', 30)
ylabel('Average relative RMSE', 'FontWeight', 'bold','FontSize', 40);
yt = get(gca, 'YTick');
set(gca, 'FontSize', 30)

lgd = legend('-DynamicLegend', 'location', 'northeast');
lgd.FontSize = 30;

%% Hmm.. let's change this
kvals = 1:1:100;

[results_euclidean_one] = compare_generic_distance_simulation(X_struct_small, kvals, numiter, 'euclidean_distance');
[results_dotproduct_one] = compare_generic_distance_simulation(X_struct_small, kvals, numiter, 'dot_product');
[results_euclidean_all] = compare_generic_distance_simulation(X_struct, kvals, numiter, 'euclidean_distance');
[results_dotproduct_all] = compare_generic_distance_simulation(X_struct, kvals, numiter, 'dot_product');



plot(kvals,mean(results_euclidean_one), 'k', 'DisplayName', 'Euclidean Distance for one pair'); hold all
plot(kvals,mean(results_dotproduct_one), 'r', 'DisplayName', 'Dot Product for one pair'); 
plot(kvals,mean(results_euclidean_all), '--k', 'DisplayName', 'Euclidean Distance for all pairs'); 
plot(kvals,mean(results_dotproduct_all), '--r', 'DisplayName', 'Dot Product for all pairs'); 

ylim([0 1])
xlim([0,100])

grid on;

title(['Plot of relative RMSE against number of dimensions projected to'], 'FontWeight', 'bold','FontSize', 30);

xlabel('Number of dimensions k', 'FontWeight', 'bold','FontSize', 40);
xt = get(gca, 'XTick');
set(gca, 'FontSize', 30)
ylabel('Average relative RMSE', 'FontWeight', 'bold','FontSize', 40);
yt = get(gca, 'YTick');
set(gca, 'FontSize', 30)

lgd = legend('-DynamicLegend', 'location', 'northeast');
lgd.FontSize = 30;


plot(kvals,std(results_euclidean_all), 'k', 'DisplayName', 'Euclidean Distance for all pairs'); hold all
plot(kvals,std(results_dotproduct_all), 'r', 'DisplayName', 'Dot Product for all pairs'); 

ylim([0 0.5])
xlim([0,100])

grid on;

title(['Plot of deviation of relative RMSE against number of dimensions projected to'], 'FontWeight', 'bold','FontSize', 30);

xlabel('Number of dimensions k', 'FontWeight', 'bold','FontSize', 40);
xt = get(gca, 'XTick');
set(gca, 'FontSize', 30)
ylabel('Deviation of relative RMSE', 'FontWeight', 'bold','FontSize', 40);
yt = get(gca, 'YTick');
set(gca, 'FontSize', 30)

lgd = legend('-DynamicLegend', 'location', 'northeast');
lgd.FontSize = 30;



%%%%%%%%%%%%%%%%
kvals = 1:1:100;
numiter = 1000;

% Use colon data
[X, ~] = load_colon();

% Two vectors: Feel free to change the parameters
rng(0)
[ X_struct_small ] = build_X_struct(X(randsample(62,2),:), false, false)  

[theo_var, est_var] = verify_variance_generic_distance_simulation(X_struct_small, kvals, numiter, 'squared_euclidean_distance');



xlim([0,100])
plot(kvals,theo_var, 'k', 'DisplayName', 'Theoretical Variance'); hold all
plot(kvals,est_var, 'r', 'DisplayName', 'Empirical Variance'); 


grid on;

title(['Plot of variance against dimensions projected to'], 'FontWeight', 'bold','FontSize', 30);

xlabel('Number of dimensions k', 'FontWeight', 'bold','FontSize', 40);
xt = get(gca, 'XTick');
set(gca, 'FontSize', 30)
ylabel('Variance of Sq. Euclidean Distance', 'FontWeight', 'bold','FontSize', 40);
yt = get(gca, 'YTick');
set(gca, 'FontSize', 30)

lgd = legend('-DynamicLegend', 'location', 'northeast');
lgd.FontSize = 30;




[theo_var, est_var] = verify_variance_generic_distance_simulation(X_struct_small, kvals, numiter, 'dot_product');



xlim([0,100])
plot(kvals,theo_var, 'k', 'DisplayName', 'Theoretical Variance'); hold all
plot(kvals,est_var, 'r', 'DisplayName', 'Empirical Variance'); 


grid on;

title(['Plot of variance against dimensions projected to'], 'FontWeight', 'bold','FontSize', 30);

xlabel('Number of dimensions k', 'FontWeight', 'bold','FontSize', 40);
xt = get(gca, 'XTick');
set(gca, 'FontSize', 30)
ylabel('Variance of Dot Product', 'FontWeight', 'bold','FontSize', 40);
yt = get(gca, 'YTick');
set(gca, 'FontSize', 30)

lgd = legend('-DynamicLegend', 'location', 'northeast');
lgd.FontSize = 30;

%%%%%%%%%%%%%%%%

eps_vals = [0.01:0.01:0.5];
eps_vals_flip = fliplr(eps_vals);

xlim([0,0.5])
plot(eps_vals_flip,9 * log(1000)./ (eps_vals.^2 - (2/3) * eps_vals.^3), 'k', 'DisplayName', '1000 observations'); hold all
plot(eps_vals_flip,9 * log(10000)./ (eps_vals.^2 - (2/3) * eps_vals.^3), 'r', 'DisplayName', '10000 observations'); 
plot(eps_vals_flip,9 * log(100000)./ (eps_vals.^2 - (2/3) * eps_vals.^3), 'b', 'DisplayName', '100000 observations'); 
plot(eps_vals_flip,9 * log(1000000)./ (eps_vals.^2 - (2/3) * eps_vals.^3), 'c', 'DisplayName', '1000000 observations'); 

grid on;

title(['Plot of k against epsilon'], 'FontWeight', 'bold','FontSize', 30);

xlabel('Epsilon', 'FontWeight', 'bold','FontSize', 40);
xt = get(gca, 'XTick');
set(gca,'XTick', 0:0.05:0.5)
set(gca,'XTickLabel', fliplr(0:0.05:0.5))
set(gca, 'FontSize', 30)

ylabel('Number of dimensions k', 'FontWeight', 'bold','FontSize', 40);
yt = get(gca, 'YTick');
set(gca, 'YScale', 'log')
set(gca, 'FontSize', 30)

lgd = legend('-DynamicLegend', 'location', 'northwest');
lgd.FontSize = 30;








