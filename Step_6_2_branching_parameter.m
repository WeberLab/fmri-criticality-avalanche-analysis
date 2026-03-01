% calculate the branching parameter

%% HY96
clc;clear;close all;
load(fullfile('step_6_branching_process_analysis', 'branching_process_HY48.mat'), 'BP_HY48');
% sub_list = 1:295; %CHANGE IT BACK LATER as rn only 1 subject
sub_list = 1;
for threshold =1:25 
        branching_parameter_wholegroup_dthreshold(threshold)= xlz_aggr_branching_parameter(sub_list, BP_HY48, threshold);
end
threshold = 14;
% for sub_list = 1:295 %CHANGE IT BACK LATER as rn only 1 subject
for sub_list = 1
        branching_parameter_eachsubj(sub_list)= xlz_aggr_branching_parameter(sub_list, BP_HY48, threshold);
end
load(fullfile('step_2_MS_SE_relationship', 'MS_SE_rel_wholebrain.mat'), 'LMHgroup')
% LMS group
sub_list = LMHgroup.LMS(:,3);
threshold = 14;
branching_parameter_LMS= xlz_aggr_branching_parameter(sub_list, BP_HY48, threshold);
% MMS group
sub_list = LMHgroup.MMS(:,3);
threshold = 14;
branching_parameter_MMS= xlz_aggr_branching_parameter(sub_list, BP_HY48, threshold);
% HMS group
sub_list = LMHgroup.HMS(:,3);
threshold = 14;
branching_parameter_HMS= xlz_aggr_branching_parameter(sub_list, BP_HY48, threshold);
% save
branching_parameter_HY48.branching_parameter_wholegroup_dthreshold = branching_parameter_wholegroup_dthreshold;
branching_parameter_HY48.branching_parameter_eachsubj = branching_parameter_eachsubj;
branching_parameter_HY48.branching_parameter_LMS = branching_parameter_LMS;
branching_parameter_HY48.branching_parameter_MMS = branching_parameter_MMS;
branching_parameter_HY48.branching_parameter_HMS = branching_parameter_HMS;
save(fullfile('step_6_branching_process_analysis', 'branching_parameter_HY48.mat'), 'branching_parameter_HY48');