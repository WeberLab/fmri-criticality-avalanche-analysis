%% define the LMS、MMS and HMS groups
clc;
clear;
close all;

load(fullfile('step_2_MS_SE_relationship', 'kuramoto_order_paramter.mat'), 'kop_sta_HY')


for sub = 1 %changed subject from 1:295 to 1!
    % import the mean synchronization
    MS(sub) = kop_sta_HY(sub).mean_kop;
    subj_ID(sub) = kop_sta_HY(sub).subj_ID;
end

% sort the MS in ascending order
[MS_value, MS_index] = sort(MS);

% LMS group
% commented out 3 lines below for running 1 subject, restore for multiple subjects
%LMHgroup.LMS(:,1) = subj_ID(MS_index(1:20));   %restore later
%LMHgroup.LMS(:,2) = MS_value(1:20);            %restore later
%LMHgroup.LMS(:,3) = MS_index(1:20);            %restore later

LMHgroup.LMS(:,1) = subj_ID(MS_index(1));   %changed for 1 subject
LMHgroup.LMS(:,2) = MS_value(1);            %changed for 1 subject
LMHgroup.LMS(:,3) = MS_index(1);            %changed for 1 subject

% MMS group
% commented out3 lines below for running 1 subject, restore for multiple subjects
%LMHgroup.MMS(:,1) = subj_ID(MS_index(201:220));   %restore later
%LMHgroup.MMS(:,2) = MS_value(201:220);            %restore later
%LMHgroup.MMS(:,3) = MS_index(201:220);            %restore later

LMHgroup.MMS(:,1) = subj_ID(MS_index(1));   %changed for 1 subject
LMHgroup.MMS(:,2) = MS_value(1);            %changed for 1 subject
LMHgroup.MMS(:,3) = MS_index(1);            %changed for 1 subject

% HMS group
% commented out 3 lines below for running 1 subject, restore for multiple subjects
%LMHgroup.HMS(:,1) = subj_ID(MS_index(276:295)); %restore later
%LMHgroup.HMS(:,2) = MS_value(276:295);          %restore later
%LMHgroup.HMS(:,3) = MS_index(276:295);          %restore later

LMHgroup.HMS(:,1) = subj_ID(MS_index(1));   %changed for 1 subject
LMHgroup.HMS(:,2) = MS_value(1);            %changed for 1 subject
LMHgroup.HMS(:,3) = MS_index(1);            %changed for 1 subject

save(fullfile('step_2_MS_SE_relationship','MS_SE_rel_wholebrain.mat'), 'kop_sta_HY', 'LMHgroup');