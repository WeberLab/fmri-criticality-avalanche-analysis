function [entropy, zeroN] = xlz_entropy(data,bins)
%% note

%% input

%% output

%% main 
    b = hist(data, bins);
    p = b ./ length(data);
    
    zeroN = length(find(p == 0));
    p(p == 0) = [];
    
    entropy = sum(p .* log2(p));
    entropy = -1 * entropy;
    
end