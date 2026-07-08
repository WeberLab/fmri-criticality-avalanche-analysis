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
ROI_number = 48;
time_length = 1200;

subject_IDs = {'111211','117021','120414','139435','143224','153126','165941','167440', '168947','176845', '111211RL','117021RL','120414RL','139435RL','143224RL','153126RL','165941RL','167440RL', '168947RL','176845RL'};

for SUB = 1:length(subject_IDs)    
    subj_ID = ['sub_', subject_IDs{SUB}];
    load(fullfile('step_3_events', 'ROI_level', 'HY48', [subj_ID, '.mat']),'peakevents');
    for THR = 1:25
        raster = peakevents.ithr(THR).raster;
        avalanches_HY48(SUB).threshold(THR).threshold = THR/10;
        avalanches_HY48(SUB).threshold(THR).sta_ava = xlz_avalanches(raster, ROI_number, time_length, timebinsize); 
    end
end
% save
save(fullfile('step_4_avalanches', 'ROI_level','HY48','avalanches_HY48.mat'), 'avalanches_HY48','-v7.3');