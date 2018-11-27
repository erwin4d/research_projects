

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