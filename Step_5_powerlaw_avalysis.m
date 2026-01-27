% step 5 power-law analysis
% loads step 2 & 4!! so work on that
%% HY96 signals
clc;
clear;
close all;
addpath Function
load(fullfile('step3_avalanches', 'avalanches_HY96.mat'), 'avalanches_HY96');
% whole 295 subjects group level 
sub_list = 1 %changed subject from 1:295 to 1
event_threshold = 14;
plfit_smin = 3; plfit_smax = 30;
plfit_tmin = 3; plfit_tmax = 9;
[powerlaw_fit_wholegroup]=xlz_aggr_ava_pl(sub_list, avalanches_HY96, event_threshold, plfit_smin, plfit_smax, plfit_tmin, plfit_tmax);
load(fullfile('step_2_MS_SE_relationship', 'MS_SE_rel_wholebrain.mat'), 'LMHgroup')
load(fullfile('step_2_MS_SE_relationship', 'LMH_subgroup.mat'), 'LMH_subgroup')

% LMS group
sub_list = LMHgroup.LMS(:,3);
event_threshold = 14;
plfit_smin = 3; plfit_smax = 30;
plfit_tmin = 2; plfit_tmax = 9;
[powerlaw_fit_LMSgroup]=xlz_aggr_ava_pl(sub_list, avalanches_HY96, event_threshold, plfit_smin, plfit_smax, plfit_tmin, plfit_tmax);
% MMS group
sub_list = LMH_subgroup.MMS(:,2); x
event_threshold = 14;
plfit_smin = 3; plfit_smax = 30;
plfit_tmin = 2; plfit_tmax = 9;
[powerlaw_fit_MMSgroup]=xlz_aggr_ava_pl(sub_list, avalanches_HY96, event_threshold, plfit_smin, plfit_smax, plfit_tmin, plfit_tmax);
% HMS group
sub_list = LMHgroup.HMS(:,3);
event_threshold = 14;
plfit_smin = 3; plfit_smax = 30;
plfit_tmin = 2; plfit_tmax = 9;
[powerlaw_fit_HMSgroup]=xlz_aggr_ava_pl(sub_list, avalanches_HY96, event_threshold, plfit_smin, plfit_smax, plfit_tmin, plfit_tmax);
% different threshold
for event_threshold= 1:1:20
        sub_list = 1:295; %change subject number
        plfit_smin = 3; plfit_smax = 30;
        plfit_tmin = 3; plfit_tmax = 9;
        [powerlaw_fit_dthreshold]=xlz_aggr_ava_pl(sub_list, avalanches_HY96, event_threshold, plfit_smin, plfit_smax, plfit_tmin, plfit_tmax);
        pl_fit_dthre(event_threshold).alpha = powerlaw_fit_dthreshold.avalancheSize.alpha;
        pl_fit_dthre(event_threshold).event_threshold = powerlaw_fit_dthreshold.threshold;
end
% save
powerlaw_analysis_HY96.powerlaw_fit_wholegroup = powerlaw_fit_wholegroup;
powerlaw_analysis_HY96.powerlaw_fit_LMSgroup = powerlaw_fit_LMSgroup;
powerlaw_analysis_HY96.powerlaw_fit_MMSgroup = powerlaw_fit_MMSgroup;
powerlaw_analysis_HY96.powerlaw_fit_HMSgroup = powerlaw_fit_HMSgroup;
powerlaw_analysis_HY96.pl_fit_dthre = pl_fit_dthre;
save(fullfile('step_5_powerlaw_analysis', 'powerlaw_analysis_HY96.mat'), 'powerlaw_analysis_HY96','-v7.3'); 
