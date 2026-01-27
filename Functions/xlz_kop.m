function [r, kop_complex] = xlz_kop(SIGNALS)
%% document
% [r, kop_complex] = f_kop(signals)
% The f_kop calculate the Kuramoto order parameter of the signals.

% First, using the Hilbert transform obtain the analytic signals of raw signals.
% Second, calculate the instaneouse phase from the analytic signals.
% Finaly, calculate the Kuramoto order parameter using the transient phase.

% Input
% SIGANLS are the siganls data from one system. the first dimension of the
% SIGNALS is the channel, the second dimension of the SIGNALS is time;

% output

%% main function
    [ele_num, time_num] = size(SIGNALS);
    
    % obtain the instaneouse phase
    for NN = 1 : ele_num
        
        a_s(NN,:) = hilbert(SIGNALS(NN,:)); %analytical signals

        theta(NN,:) = angle(a_s(NN,:));% instaneouse phases
    end
    
    phase = exp(theta * 1i); % the unit vector of phase
    
    % calculate the Kurumoto order parameteres at each time point
    kop_complex = sum(phase, 1);
    
    r = abs(kop_complex) / ele_num;
end