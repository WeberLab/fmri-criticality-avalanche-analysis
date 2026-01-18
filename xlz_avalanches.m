function [avalanches] = xlz_avalanches(raster, channel_length, time_length, timebinSize)
%% notes
%
%% input
%
%% output
%
%% main function
    % check the dimension of raster
    Size = size(raster);
    if channel_length ~= Size(1)
        error('wrong ROI length')
    end
    if time_length ~= Size(2)
        error('wrong time length')
    end
    
    % sum the event
    event_sum = sum(raster,1);
    
    % bin the event serise
    num_bins = floor(time_length / timebinSize);
    eventsum_bin(1,:) = sum(reshape(event_sum(1 : num_bins*timebinSize), num_bins, timebinSize), 2);
    eventsum_bin = [0, eventsum_bin, 0];
    
    % detect the avalanche and calculate the property of each avalanche
    iZeroBin = find(eventsum_bin == 0);
    iav = 0; % the index of avalanche  
    for TT = 1 : length(iZeroBin) - 1
        AA = iZeroBin(TT+1) - iZeroBin(TT);
        if  AA > 1
            iav = iav + 1; 
            
            avalanches.begin_time(iav) = iZeroBin(TT) + 1 - 1;% the begin time point of each avalanche
            
            avalanches.end_time(iav) = iZeroBin(TT + 1) - 1 - 1;% the end time point of each avalanche
            
            avalanches.shape{iav} = eventsum_bin(iZeroBin(TT) + 1 : iZeroBin(TT+1) - 1);
            
            % calculate the duration of each avalanche
            avalanches.duration(iav) = avalanches.end_time(iav) - avalanches.begin_time(iav) + 1;
            
            % calculate the size of each avalanche
            avalanches.size(iav) = sum(avalanches.shape{iav});
            
            % check the possible wrong
            if sum(avalanches.shape{iav} == 0) > 1 
                error('wrong algorithm');
            end
            
        end
    end
end

