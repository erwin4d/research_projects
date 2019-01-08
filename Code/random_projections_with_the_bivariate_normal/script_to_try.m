% Plots of variance of ordinary inner product estimate and Li's estimate
% Assumption: m1 = m2 = 1 

avec = -1:0.01:1;
orig_var = 1 + avec.^2;
li_var = (1-avec.^2).^2 ./ (1 + avec.^2);

plot(avec,orig_var, 'r', 'DisplayName', 'Original variance for dot product'); hold all
plot(avec,li_var, 'b', 'DisplayName', 'Li''s variance for dot product'); 


grid on;

title(['Plot of variances of dot product with normalized vectors'], 'FontWeight', 'bold','FontSize', 30);

xlabel('Value of dot product', 'FontWeight', 'bold','FontSize', 40);
xt = get(gca, 'XTick');
set(gca, 'FontSize', 30)
ylabel('Variance of estimate of dot product', 'FontWeight', 'bold','FontSize', 40);
yt = get(gca, 'YTick');
set(gca, 'FontSize', 30)

lgd = legend('-DynamicLegend', 'location', 'northeast');
lgd.FontSize = 30;