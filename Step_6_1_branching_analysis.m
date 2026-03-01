%% convet the avalanche to branching process

%% HY96
clc; clear; close all;
addpath('Functions');
load(fullfile('step_4_avalanches', 'ROI_level', 'HY48', 'avalanches_HY48.mat'))
% sub_list = 1:295; %CHNAGE IT BACK LATER as rn only 1 subject
sub_list = 1;
for N = 1:length(sub_list)
    sub = sub_list(N)
    threshold = 0;
    for TT = 1:25
        threshold = threshold + 0.1;
        shape = avalanches_HY48(sub).threshold(TT).sta_ava.shape;
        BP_HY48.sub(sub).thr(TT).branching_ratio_series = xlz_shape2branchingprocess(shape);
        BP_HY48.sub(sub).thr(TT).threshold = threshold;
    end
end
mkdir('step_6_branching_process_analysis');
save(fullfile('step_6_branching_process_analysis', 'branching_process_HY48.mat'), 'BP_HY48');
