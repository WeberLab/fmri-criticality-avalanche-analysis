%this code translate the HCP resting data to the mat data
clc; clear; close all
%data_file = 'HCP_rfMRI_SingleSubjectData/rfMRI_REST1_LR_hp2000_clean.nii.gz'; %the path of the RS-fMRI data from HCP
data = niftiread('HCP_rfMRI_SingleSubjectData/rfMRI_REST1_LR_hp2000_clean.nii'); %the path of the RS-fMRI data from HCP;  % DPABI function used to read NIFTI files


%% Extract ROI signals
% HY_96
load(['MASK/parcellated_timeseries.mat']);
for roi = 1:48
    clear RS_HY_48_voxceL_signals index data_aftermask
    mkdir(['voxcel_signals/HY_48/ROI',num2str(roi)]);
    data_aftermask = data(:, :, :, 1) .* HY_48;
    index = find_nonzero_3d(data_aftermask);
    for I = 1:length(index)
            RS_HY_48_voxceL_signals(I, :) = data(index(I, 1), index(I, 2), index(I, 3), :);
    end
        save(['voxcel_siganls/HY_48/', file_folder(S,1).name, '/ROI',num2str(roi),'/voxcel_signals.mat'],'RS_HY_48_voxceL_signals');
        save(['voxcel_siganls/HY_48/', file_folder(S,1).name, '/ROI',num2str(roi),'/index_HY48.mat'],'index');
        rest_HY96_ROI(:, roi) = mean(RS_HY_48_voxceL_signals, 1);
end
mkdir('ROI_signals\HY_48');
save(['ROI_signals\HY_48\sub', num2str(S), '.mat'], 'rest_HY48_ROI');