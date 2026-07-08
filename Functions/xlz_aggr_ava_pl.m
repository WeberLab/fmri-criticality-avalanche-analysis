function [powerlaw_fit]=xlz_aggr_ava_pl(sub_list, avalanches, event_threshold, plfit_smin, plfit_smax, plfit_tmin, plfit_tmax)
        addpath('Functions/CritAnalysisSoftwarePackage2016-04-25');
        sizes = [];
        durations = [];
        for N = 1:length(sub_list)
                SUB = sub_list(N);
                sizes = [sizes, avalanches(SUB).threshold(event_threshold).sta_ava.size];
                durations = [durations, avalanches(SUB).threshold(event_threshold).sta_ava.duration];
        end
        
        % power law fit of size
        [alpha, s_min, s_max] = plmle(sizes, 'xmin', plfit_smin, 'xmax', plfit_smax);
        % p vaule of power law fit
        p_alpha = pvcalc(sizes, alpha, 'xmin', s_min, 'xmax', s_max);
        % power law fit of durations
        [tau, t_min, t_max] = plmle(durations, 'xmin', plfit_tmin, 'xmax', plfit_tmax);
        % p value of power law
        p_tau = pvcalc(durations, tau, 'xmin', t_min, 'xmax', t_max);

        powerlaw_fit.threshold=event_threshold/10;
        powerlaw_fit.avalancheSize.sizes = sizes;
        powerlaw_fit.avalancheSize.alpha = alpha;
        powerlaw_fit.avalancheSize.s_max = s_max;
        powerlaw_fit.avalancheSize.s_min = s_min;
        powerlaw_fit.avalancheSize.p_alpha = p_alpha;
        powerlaw_fit.avalancheDuration.durations = durations;
        powerlaw_fit.avalancheDuration.tau=tau;
        powerlaw_fit.avalancheDuration.t_max=t_max;
        powerlaw_fit.avalancheDuration.t_min=t_min;
        powerlaw_fit.avalancheDuration.p_tau = p_tau;

        % calculate the relationship between sizes and duration
        gamma_mle = (tau-1) / (alpha-1);
        [Lifetime, AverageSize]=xlz_lifetimeAverageSize(durations, sizes);
        %[gamma_nlsfit] = xlz_fit_plnonlinearLS(Lifetime(plfit_tmin:plfit_tmax), AverageSize(plfit_tmin:plfit_tmax));
        %change added here below
        fit_tmax = min(plfit_tmax, length(Lifetime));

        if plfit_tmin <= fit_tmax
                [gamma_nlsfit] = xlz_fit_plnonlinearLS( ...
                        Lifetime(plfit_tmin:fit_tmax), ...
                        AverageSize(plfit_tmin:fit_tmax));
        else
                gammaFromFit = NaN;
        end
        % change added here above
        averageSizeFit = (gamma_nlsfit.a).*(plfit_tmin:plfit_tmax).^(gamma_nlsfit.b);
        gammaFromFit = gamma_nlsfit.b;
        delta = abs(gamma_mle-gammaFromFit);

        powerlaw_fit.avalancheScalerelationship.gamma =  gamma_mle;
        powerlaw_fit.avalancheScalerelationship.duration =  Lifetime;
        powerlaw_fit.avalancheScalerelationship.size =  AverageSize;
        powerlaw_fit.avalancheScalerelationship.gamma_fit =  gammaFromFit;
        powerlaw_fit.avalancheScalerelationship.delta=  delta;
        powerlaw_fit.avalancheScalerelationship.averageSizeFit =  averageSizeFit;

end