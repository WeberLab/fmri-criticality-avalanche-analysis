function [fitresult, gof, output] = xlz_fit_plnonlinearLS(x, y)

%
%  Data for 'untitled fit 1' fit:
%      X Input : size_range
%      Y Output: ava_size_fit_p
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%

%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( 'power1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
% opts.Robust = 'LAR';
% opts.Algorithm = 'Levenberg-Marquardt';
opts.StartPoint = [0.43366588132904 -1.55666393334776];

% Fit model to data.
[fitresult, gof, output] = fit( xData, yData, ft, opts );

end
