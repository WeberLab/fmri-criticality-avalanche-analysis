%% step 2: calculate the mean synchronization (MS) and synchronization entropy(SE)

%% HY48-ROI signals
clc;
clear;
close all
addpath('Functions')

% load the ROI signals 

% calculate the MS, SE and Kuramoto order paramater
load(fullfile('MASK', 'ROIsignals.mat'), 'ROIsignals_HY');

for sub = 1:length(ROIsignals_HY)
    sub

    % ROI signals
    time_len = 1200;
    node_num = 48;
    signals = ROIsignals_HY(sub).ROIsignals(1:node_num, 1:time_len);
    
    % z-score normalized signals
    signals_zs = zscore(signals');
    
    %calculate the kuramoto parameter
    kop = xlz_kop(signals_zs');
    bins_num = 30;
    [MS(sub), SS(sub), CS(sub), SE(sub), sample_failed] =  xlz_kop2sta(kop, bins_num);
    
    kop_sta_HY(sub).subj_ID = ROIsignals_HY(sub).subj_id;
    kop_sta_HY(sub).kop = kop;
    kop_sta_HY(sub).mean_kop = MS(sub);
    kop_sta_HY(sub).min_kop = min(kop);
    kop_sta_HY(sub).max_kop = max(kop);
    kop_sta_HY(sub).std_kop = SS(sub);
    kop_sta_HY(sub).cv_kop = CS(sub);
    kop_sta_HY(sub).bins_num = bins_num; 
    kop_sta_HY(sub).entropy_kop = SE(sub);
    kop_sta_HY(sub).sample_failed = sample_failed;
    
end

save(fullfile('step_2_MS_SE_relationship', 'kuramoto_order_paramter.mat'), 'kop_sta_HY', '-v7.3')