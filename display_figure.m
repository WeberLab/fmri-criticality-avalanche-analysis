%% plot the figure 1
clc;
clear;
close all;
figure('Color', 'w', ...
      'Units', 'Normalized', ...
      'Name', 'Figure 1 Power-law distribution fot the aggregate level reflecting the brain near criticality in the resting state', ...
      'Position', [0.1 0.1 0.8 0.8]);

%% figure 1a
AX1=subplot(2,3,[1,2]);
% load(fullfile('step_1_extract_ROI_signals', 'ROI_signals', 'ROIsignals.mat'), 'ROIsignals_HY'); %load the ROI signals
load(fullfile('MASK', 'parcellated_timeseries.mat'))
%Signals_original = ROIsignals_HY(1).ROIsignals;
Signals_original = time_series';
Signal_normalized = zscore(Signals_original')'; % z-score
%load('step_3_events\ROI_level\HY96\sub_001.mat', 'peakevents')
load('step_2_events/ROI_level/HY48/sub_001.mat', 'peakevents')
Event = peakevents.ithr(14).raster; % avalanche event
threshold = 1.4 * ones(1200,1); % define the threshold
% plot
plot(1:1200, Signal_normalized(5, :), 'Color', [0,0,0], 'LineStyle', '-', 'LineWidth', 1); % plot the signal example
hold on
plot(1:1200, threshold, 'Color', [0,1,0], 'LineStyle', '--', 'LineWidth', 1); 
plot(find(Event(5,1:1200)>0), 3.5*ones(length(find(Event(5, 1:1200)>0))), 'Color', [1,0,0], 'LineStyle', 'none', ...
    'LineWidth', 2, 'Marker', '.', 'MarkerSize', 10);
xlabel('time (vol.)', 'FontName', 'Arial');
ylabel('BOLD', 'FontName', 'Arial');
set(gca, 'FontName', 'Arial', 'FontSize', 18);
grid off; 
AX1.LineWidth = 2; 
box(AX1, 'off'); 
hold off
title('(a)', 'FontName', 'Arial', 'FontSize', 24, 'units', 'normalized', ...
    'FontWeight', 'bold', 'position', [-1/36,1+1/18], 'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'bottom');

%% figure 1b 
AX1 = subplot(2,3,3);
load(fullfile('step_5_powerlaw_analysis', 'powerlaw_analysis_HY96.mat'), 'powerlaw_analysis_HY96')
alpha = powerlaw_analysis_HY96.powerlaw_fit_wholegroup.avalancheSize.alpha;
p_alpha = powerlaw_analysis_HY96.powerlaw_fit_wholegroup.avalancheSize.p_alpha;
s_max = powerlaw_analysis_HY96.powerlaw_fit_wholegroup.avalancheSize.s_max;
s_min = powerlaw_analysis_HY96.powerlaw_fit_wholegroup.avalancheSize.s_min;
Size = powerlaw_analysis_HY96.powerlaw_fit_wholegroup.avalancheSize.sizes;
size_range = min(Size):max(Size);
size_distribution = hist(Size, size_range);
size_distribution = size_distribution/size_distribution(1);
size_plfit_range = s_min:s_max;
size_plfit_distribution = size_plfit_range.^(-alpha);

F1 = loglog(size_range, size_distribution, 'Color', [0.50, 0.50, 0.50], ...
    'LineStyle', 'none', 'LineWidth', 2, 'Marker', 'o', 'MarkerSize',6);
hold on;
F2 = loglog(size_plfit_range, size_plfit_distribution, ...
    'Color', [0,1,0], ...
    'LineStyle', '--', ...
    'LineWidth',2.5);
text(0.55, 0.8, ['$\alpha= ', num2str(round(alpha, 2)), '$'], ...
    'units', 'normalized', 'Interpreter','latex', 'Color', [0.00,0.00,0.00], ...
    'FontName', 'Arial', 'FontSize', 20, 'EdgeColor','none');
text(0.55, 0.7, ['$p= ', num2str(round(p_alpha, 2)), '$'], ...
    'units', 'normalized', 'Interpreter','latex', 'Color', [0.00,0.00,0.00], ...
    'FontName', 'Arial', 'FontSize', 20, 'EdgeColor','none');
legend(F1, 'real data', 'Location', 'southwest', 'FontName', 'Arial', 'FontSize', 15, 'EdgeColor', [1,1,1])
legend('boxoff')
xlabel('avalanche size S', 'FontName', 'Arial');
ylabel('P(S)', 'FontName', 'Arial');
set(gca, 'FontName', 'Arial', 'FontSize',18, ...
    'XTick', [1,10,100,1000], 'YTick', [0.00001,0.0001,0.001,0.01,0.1,1]);
grid off; 
AX1.LineWidth = 2; 
box(AX1,'off'); 
hold off
title('b', 'FontName','Arial', 'FontSize', 24, 'FontWeight', 'bold', ....
    'units', 'normalized', 'position', [-1/18,1+1/18], 'HorizontalAlignment', 'right', ...
    'VerticalAlignment','bottom');