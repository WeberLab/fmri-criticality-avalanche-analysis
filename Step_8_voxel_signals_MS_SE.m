%% step 2.2 calcualte the MS and SE of a ROI
% setting environment and workspace
clc;clear;close all
addpath('Functions')

%% calculate the MS and SE in each ROI using the BN246 vox-wise signals
% setting
clc; clear; close all;

%set the voxcel siganls path
%set the file folder
F_F = 'step_1\voxcel_signals\BN_246';
% set the subject folder
SUB_F = dir(F_F);
SUB_F = SUB_F(3:end); 
% set the voxcel signals filename
VOX_s_fn = 'voxcel_signals.mat'; 

% calculate the MS and SE of each ROI of each subject
for SUB=1:295
    for ROI=1:246
        
        % set the voxcel signals path 
        % set the voxcel signals folder
        clear vox_s_f
        vox_s_f = ['ROI',num2str(ROI)];
        VOX_s_p = [F_F,'\',SUB_F(SUB).name,'\',vox_s_f,'\',VOX_s_fn];
        load(VOX_s_p);
        clear signals
        signals = RS_BN_246_voxceL_signals';
        clear RS_BN_246_voxceL_signals
        
        % Z-score normalization
        signals_zs = zscore(signals);
    
        % calculate the MS and SE
        time_len = 1200;
        node_num = length(signals(1,:));
        entropy_bin = 30;
        [syn(ROI,SUB),synE(ROI,SUB)] = syn_synEntropy(signals_zs, time_len, node_num, entropy_bin);
    end
    subject(SUB,1)=str2double(SUB_F(SUB,1).name);
end
save('MS_SE_BN246_ROI.mat','syn','synE','subject');
%% calculate the MS and SE using HY96 vox-wise signals
% setting
clc; clear; close all;

%set the voxcel siganls path
%set the file folder
F_F = 'step_1\voxcel_signals\HY_96';
% set the subject folder
SUB_F = dir(F_F);
SUB_F = SUB_F(3:end); 
% set the voxcel signals filename
VOX_s_fn = 'voxcel_signals.mat'; 

% calculate the MS and SE of each ROI of each subject
for SUB=1:295
    for ROI=1:96
        
        % set the voxcel signals path 
        % set the voxcel signals folder
        clear vox_s_f
        vox_s_f = ['ROI',num2str(ROI)];
        VOX_s_p = [F_F,'\',SUB_F(SUB).name,'\',vox_s_f,'\',VOX_s_fn];
        load(VOX_s_p);
        clear signals
        signals = RS_HY_96_voxceL_signals';
        clear RS_HY_96_voxceL_signals
    
        % Z-score normalization
        signals_zs = zscore(signals);
    
        % calculate the MS and SE
        time_len = 1200;
        node_num = length(signals(1,:));
        entropy_bin = 30;
        [syn(ROI,SUB),synE(ROI,SUB)] = syn_synEntropy(signals_zs, time_len, node_num, entropy_bin);
    end
    subject(SUB,1)=str2double(SUB_F(SUB,1).name);
end
save('MS_SE_BN246_ROI.mat','syn','synE','subject');