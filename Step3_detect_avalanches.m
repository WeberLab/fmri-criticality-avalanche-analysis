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