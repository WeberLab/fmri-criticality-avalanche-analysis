function branching_parameter = xlz_aggr_branching_parameter(sub_list, branching_process, threshold)
%% note

%% main function
        branching_ratio_series = [];
        for N = 1:length(sub_list)
                SUB = sub_list(N);
                branching_ratio_series = [branching_ratio_series, branching_process.sub(SUB).thr(threshold).branching_ratio_series];
        end
        branching_parameter = mean(branching_ratio_series);
end