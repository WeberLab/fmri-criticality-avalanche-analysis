%% bundle_subjects.m
% Run this ONCE before all other steps
clc; clear; close all

files = dir(fullfile('MASK', 'parcellated_timeseries_*.mat'));

for SUB = 1:length(files)
    data = load(fullfile('MASK', files(SUB).name));
    ROIsignals_HY(SUB).ROIsignals = data.time_series';
    ROIsignals_HY(SUB).subj_id = strrep(strrep(files(SUB).name, 'parcellated_timeseries_', ''), '.mat', '');
end

save(fullfile('MASK', 'ROIsignals.mat'), 'ROIsignals_HY');
disp('Done! All subjects bundled into ROIsignals.mat')