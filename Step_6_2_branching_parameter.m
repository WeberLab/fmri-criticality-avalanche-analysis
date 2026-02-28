% calculate the branching parameter

%% HY96
clc;clear;close all;
load(fullfile('step_6_branching_process_analysis', 'branching_process_HY96.mat'), 'BP_HY96');
sub_list = 1:295;
for threshold =1:25 
        branching_parameter_wholegroup_dthreshold(threshold)= xlz_aggr_branching_parameter(sub_list, BP_HY96, threshold);
end
threshold = 14;
for sub_list = 1:295
        branching_parameter_eachsubj(sub_list)= xlz_aggr_branching_parameter(sub_list, BP_HY96, threshold);
end
load(fullfile('step_2_MS_SE_relationship', 'MS_SE_rel_wholebrain.mat'), 'LMHgroup')
% LMS group
sub_list = LMHgroup.LMS(:,3);
threshold = 14;
branching_parameter_LMS= xlz_aggr_branching_parameter(sub_list, BP_HY96, threshold);
% MMS group
sub_list = LMHgroup.MMS(:,3);
threshold = 14;
branching_parameter_MMS= xlz_aggr_branching_parameter(sub_list, BP_HY96, threshold);
% HMS group
sub_list = LMHgroup.HMS(:,3);
threshold = 14;
branching_parameter_HMS= xlz_aggr_branching_parameter(sub_list, BP_HY96, threshold);
% save
branching_parameter_HY96.branching_parameter_wholegroup_dthreshold = branching_parameter_wholegroup_dthreshold;
branching_parameter_HY96.branching_parameter_eachsubj = branching_parameter_eachsubj;
branching_parameter_HY96.branching_parameter_LMS = branching_parameter_LMS;
branching_parameter_HY96.branching_parameter_MMS = branching_parameter_MMS;
branching_parameter_HY96.branching_parameter_HMS = branching_parameter_HMS;
save(fullfile('step_6_branching_process_analysis', 'branching_parameter_HY96.mat'), 'branching_parameter_HY96');