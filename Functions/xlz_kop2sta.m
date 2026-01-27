function [mean_syn, std_syn, cv_syn, entropy_syn, sample_failed] =  x_kop2sta(kop, bins_num)
%% notes:
%    The f_kop2sta calculate the statistical measure of Kuramoto order parameter
%% input:
%   kop
%   bins_num
%% output:
%    mean_kop  mean of Kuramoto order parameter
%    std_kop   standard deviation of Kuramoto order parameter
%    cv_kop    coefficient of variation of Kuramoto order parameter
%    entropy_kop entropy of Kuramoto order parameter
%% main

        mean_syn = mean(kop); % mean of Kuramoto order parameter
        
        std_syn = std(kop); % standard deviation of Kuramoto order parameter
        
        cv_syn = std_syn/mean_syn; % coefficient of variation of Kuramoto order parameter
        
        % [0, 1] normalize
        kop_max = max(max(kop));
        kop_min = min(min(kop));
        kop_nor = (kop - kop_min)./(kop_max - kop_min); 
        
        % calculate the synchrony entropy
        bins = linspace(0, 1, bins_num);
        [entropy_syn, sample_failed] = xlz_entropy(kop_nor, bins);

end