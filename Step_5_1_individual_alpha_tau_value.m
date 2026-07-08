alpha_vals = zeros(1,20);
tau_vals   = zeros(1,20);

for i = 1:20
    sizes = avalanches_HY48(i).threshold(14).sta_ava.size;
    durations = avalanches_HY48(i).threshold(14).sta_ava.duration;

    [alpha_vals(i), ~, ~] = plmle(sizes, 'xmin', 3, 'xmax', 30);
    [tau_vals(i), ~, ~]   = plmle(durations, 'xmin', 3, 'xmax', 9);
end

