function [fitresult, fitx, fity, gof, output] = xlz_fit_poly2(X, Y)

%
%  Data for 'untitled fit 1' fit:
%      X Input : syn_rest_include
%      Y Output: connect_number_entropy1_include
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.

%% main
    [xData, yData] = prepareCurveData( X, Y);

    % Set up fittype and options.
    ft = fittype( 'poly2' );

    % Fit model to data.
    [fitresult, gof, output] = fit(xData, yData, ft);

    p1 = fitresult.p1;
    p2 = fitresult.p2;
    p3 = fitresult.p3;

    d = (max(X)-min(X))/100;

    fitx = min(X) - 2*d : d : max(X) + 2*d; 

    fity = p1 .* (fitx) .^ 2 + p2 .* fitx + p3; 

end