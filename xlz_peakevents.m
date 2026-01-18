function [raster, fingerprint]=x_peakevents(signals, threshold, time_length, node_num)
%% note

%% input

%% output

%% main function
    t_len = length(signals(1,:));
    n_num = length(signals(:,1));
    % check the dimension
    if time_length ~= t_len
        error('time dimension wrong')
    end
    if node_num ~= n_num
        error('node dimension wrong')
    end
    
    % check the if the signals are zscore normalized
    if sum(std(signals')) ~= n_num || sum(mean(signals, 2)) > 0.01
        error('signals without normalizing')
    end
    
    % convert the signals to raster
    raster = zeros(n_num, t_len);
    for ROI = 1 : n_num
        for TT = 1 : t_len-2
            if signals(ROI, TT) >= threshold && signals(ROI, TT+1) >= threshold ...
                    && signals(ROI, TT+2) >= threshold
                
                if  signals(ROI, TT) <= signals(ROI, TT+1) ...
                        && signals(ROI, TT+1) >= signals(ROI, TT+2)
                    raster(ROI, TT+1) = 1;
                end
                
            end
        end
    end
    % convert the raster to fingerprint
    [row, col] = find(raster == 1);
    fingerprint.time = col;
    fingerprint.node = row;
end