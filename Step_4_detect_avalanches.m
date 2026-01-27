%% step 4: define the avalanche
clc;
clear;
close all
addpath('Functions')

%% detect the avalanches of HY48-ROIsignals
mkdir(fullfile('step_4_avalanches', 'ROI_level', 'HY48'));
clc;
clear;
close all;
timebinsize = 1;
ROI_number = 48;   %they have 96
time_length = 1200;
for SUB = 1.      % changed from 1:295 as we only have 1 subject right now!
    subj_ID = ['sub_', num2str(SUB, '%03d')];
    %load(fullfile('step_3_events', 'ROI_level', 'HY96', [subj_ID, '.mat']), 'peakevents');
    load(fullfile('step_3_events', 'ROI_level', 'HY48', 'sub_001.mat'), 'peakevents'); % changed as only 1 subject!
    for THR = 1: 25
        raster = peakevents.ithr(THR).raster;
        avalanches_HY48(SUB).threshold(THR).threshold = THR/10;
        avalanches_HY48(SUB).threshold(THR).sta_ava = xlz_avalanches(raster, ROI_number, time_length, timebinsize); 
    end
end
% save
save(fullfile('step_4_avalanches', 'ROI_level','HY48','avalanches_HY48.mat'), 'avalanches_HY48','-v7.3');