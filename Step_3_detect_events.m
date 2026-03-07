%% step two: detect the peak events
clc;
clear;
close all
addpath('Functions')

%% detect the peak events of HY-48 ROI signals
load(fullfile('MASK', 'parcellated_timeseries.mat'));
mkdir(fullfile('step_3_events', 'ROI_level', 'HY48'));
for SUB = 1 %changed it from 1:295
    %subj_ID = ['sub_', num2str(SUB, '%03d')]
    subj_ID = 'sub_001'; 
    II = 0;
    clear peakevents
    for threshold = 0.1 : 0.1 : 3
        II = II + 1;
        signals = time_series';
        signals = zscore(signals')';
        time_length = 1200;
        node_num = 48;
        [peakevents.ithr(II).raster, peakevents.ithr(II).fingerprint] = xlz_peakevents(signals, threshold, time_length, node_num);
        peakevents.ithr(II).threshold = threshold;
    end
    peakevents.threshold = 0.1 : 0.1 : 3;
    % save
    save(fullfile('step_3_events', 'ROI_level','HY48', 'sub_001.mat'), 'peakevents');
end

%% create a plot to the events

AX1=subplot(2,3,[1,2]);
load(fullfile('MASK', 'parcellated_timeseries.mat')); %load the ROI signals
Signals_original = time_series';
Signal_normalized = zscore(Signals_original, 0, 2);
load('step_3_events/ROI_level/HY48/sub_001.mat', 'peakevents')
Event = peakevents.ithr(14).raster; % avalanche event??????
threshold = 1.4 * ones(1200,1); % define the threshold
% plot
plot(1:1200, Signal_normalized(5, :), 'Color', [0.5,0.5,0.5], 'LineStyle', '-', 'LineWidth', 1); % plot the signal example
hold on
plot(1:1200, threshold, 'Color', [0,1,0], 'LineStyle', '--', 'LineWidth', 1);

thr_val = 1.4; % same threshold value used above
event_idx_all = find(Event(5,1:1200) > 0);
event_idx = event_idx_all(Signal_normalized(5, event_idx_all) > thr_val);
marker_y = thr_val + 1.3; % vertical offset above threshold
if ~isempty(event_idx)
    plot(event_idx, marker_y * ones(size(event_idx)), 'Marker', '^', 'LineStyle', 'none', ...
        'MarkerEdgeColor', [1,0,0], 'MarkerFaceColor', [1,0,0], 'MarkerSize', 8);
end
xlabel('time (vol.)', 'FontName', 'Arial');
ylabel('BOLD', 'FontName', 'Arial');
set(gca, 'FontName', 'Arial', 'FontSize', 18, 'Color', 'w');
ax = gca;
ax.XColor = 'k';     % x-axis line + ticks become black
ax.YColor = 'k';     % y-axis line + ticks become black
ax.ZColor = 'k';     % if 3D

ax.Title.Color      = 'k';  % title text black
ax.XLabel.Color     = 'k';  % x-axis label black
ax.YLabel.Color     = 'k';  % y-axis label black
grid off; 
AX1.LineWidth = 2; 
box(AX1, 'off'); 
hold off
title('(a)', 'FontName', 'Arial', 'FontSize', 24, 'units', 'normalized', ...
    'FontWeight', 'bold', 'position', [-1/36,1+1/18], 'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'bottom');