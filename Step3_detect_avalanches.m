%% step 4: define the avalanche
clc;
clear;
close all
addpath('Functions')
%% detect the avalanches of HY48-ROIsignals
mkdir(fullfile('step_3_avalanches', 'ROI_level', 'HY48'));
clc;
clear;
close all;
timebinsize = 1;
ROI_number = 48;
time_length = 1200;
for SUB = 1
    subj_ID = ['sub_', num2str(SUB, '%03d')];
    load(fullfile('step_2_events', 'ROI_level', 'HY48', 'sub_001.mat'), 'peakevents');
    for THR = 1: 25
        raster = peakevents.ithr(THR).raster;
        avalanches_HY48(SUB).threshold(THR).threshold = THR/10;
        avalanches_HY48(SUB).threshold(THR).sta_ava = xlz_avalanches(raster, ROI_number, time_length, timebinsize); 
    end
end
% save
save(fullfile('step_3_avalanches', 'ROI_level','HY48','avalanches_HY48.mat'), 'avalanches_HY48','-v7.3');

%% create a plot to detect avalanches for single subject [figure 1a]
clc; 
clear; 
close all

% load ROI signals
load('MASK/parcellated_timeseries.mat'); % time_series variable 
Signal_normalized = zscore(time_series', 0, 2); % z-score across time

% load detected avalanches
load('step_3_avalanches/ROI_level/HY48/avalanches_HY48.mat');  % loads avalanches_HY48
ava = avalanches_HY48(1).threshold(14).sta_ava; % threshold = 1.4 SD and assign to ava variable

% define threshold
thr_val = 1.4; 
threshold = thr_val*ones(1, size(Signal_normalized,2));

figure('Color','w','Position',[300 300 800 400]);
hold on
plot(1:size(Signal_normalized,2), Signal_normalized(5,:), 'Color',[0.5 0.5 0.5],'LineWidth',1);
plot(1:size(Signal_normalized,2), threshold,'g--','LineWidth',1);

% plot avalanches
marker_y = thr_val + 1.3;
for k = 1:length(ava.begin_time)
    plot(ava.begin_time(k):ava.end_time(k), marker_y*ones(1,ava.end_time(k)-ava.begin_time(k)+1), ...
        '^','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',6,'LineStyle','none');
end

xlabel('time (vol.)'); ylabel('BOLD');
set(gca,'FontSize',14,'Box','off'); title('(a)');
hold off