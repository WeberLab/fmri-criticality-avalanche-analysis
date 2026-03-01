function [branching_process] = xlz_shape2branchingprocess(shape)
%note

%% main function
        number_events = 0;
        events_length = 0;
        for num_ava = 1:length(shape)
                events_length = events_length+length(shape{num_ava});
                oneavalanche = [shape{num_ava}, 0];
                for nn = 1:length(oneavalanche)-1
                     number_events = number_events + 1;
                     branching_process(number_events) = oneavalanche(nn+1)/oneavalanche(nn);
                end
        end
        if events_length ~= number_events
            error('wrong')
        end
end